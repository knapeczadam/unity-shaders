using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


namespace UnityStandardAssets.SceneUtils
{
    public class ModelSceneControl : MonoBehaviour
    {
        public enum Mode
        {
            Activate
        }

        public bool clearOnChange = false;
        public bool mouseWheelZoom = false;
        public Text titleText;
        public Transform sceneCamera;
        public Text instructionText;
        public Button previousButton;
        public Button nextButton;

        private DemoModelSystemList demoModels = new DemoModelSystemList();
        private List<Transform> m_CurrentModelList = new List<Transform>();
        private static int s_SelectedIndex = 0;
        private static string[] s_GUIDs;
        private static string[] s_Instructions;
        private static int[] s_CamOffsets;
        private static string[] s_URLs;
        private Vector3 m_CamOffsetVelocity = Vector3.zero;
        private Vector3 m_LastPos;
        public static DemoModelSystem s_Selected;


        private void Awake()
        {
            LoadInstructions();
            LoadModels();
            Select(s_SelectedIndex);

            previousButton.onClick.AddListener(Previous);
            nextButton.onClick.AddListener(Next);
        }


        private void OnDisable()
        {
            previousButton.onClick.RemoveListener(Previous);
            nextButton.onClick.RemoveListener(Next);
        }


        private void Previous()
        {
            s_SelectedIndex--;
            if (s_SelectedIndex == -1)
            {
                s_SelectedIndex = demoModels.items.Length - 1;
            }

            Select(s_SelectedIndex);
        }


        public void Next()
        {
            s_SelectedIndex++;
            if (s_SelectedIndex == demoModels.items.Length)
            {
                s_SelectedIndex = 0;
            }

            Select(s_SelectedIndex);
        }


        private void Update()
        {
            KeyboardInput();
            MouseInput();
            sceneCamera.localPosition = Vector3.SmoothDamp(sceneCamera.localPosition,
                Vector3.forward * -s_Selected.camOffset,
                ref m_CamOffsetVelocity, 1);

            if (Input.GetKeyUp(KeyCode.L) && s_Selected.Url != null)
            {
                foreach (string url in s_Selected.Url.Split(','))
                {
                    System.Diagnostics.Process.Start(url);
                }
            }
            
            if (s_Selected.mode == Mode.Activate)
            {
                return;
            }
        }

        void KeyboardInput()
        {
            if (Input.GetKeyDown(KeyCode.LeftArrow))
                Previous();

            if (Input.GetKeyDown(KeyCode.RightArrow))
                Next();
        }

        void MouseInput()
        {
            if (mouseWheelZoom)
            {
                float scroll = Input.GetAxis("Mouse ScrollWheel");
                if (scroll > 0)
                {
                    s_Selected.camOffset -= 1;
                }
                else if (scroll < 0)
                {
                    s_Selected.camOffset += 1;
                }
            }
        }

        private void Select(int i)
        {
            s_Selected = demoModels.items[i];
            foreach (var otherEffect in demoModels.items)
            {
                if ((otherEffect != s_Selected) && (otherEffect.mode == Mode.Activate))
                {
                    otherEffect.transform.gameObject.SetActive(false);
                }
            }

            if (s_Selected.mode == Mode.Activate)
            {
                s_Selected.transform.gameObject.SetActive(true);
            }

            if (clearOnChange)
            {
                while (m_CurrentModelList.Count > 0)
                {
                    Destroy(m_CurrentModelList[0].gameObject);
                    m_CurrentModelList.RemoveAt(0);
                }
            }

            instructionText.text = s_Selected.instructionText;
            titleText.text = s_Selected.transform.name;
        }

        private void LoadInstructions()
        {
            TextAsset ta = Resources.Load("model_data") as TextAsset;
            string[] lines = ta.text.Split('\n');
            
            s_Instructions = new string[lines.Length];
            s_CamOffsets = new int[lines.Length];
            s_GUIDs = new string[lines.Length];
            s_URLs = new string[lines.Length];
            
            for (var i = 0; i < lines.Length; i++)
            {
                string[] line = lines[i].Split('|');

                s_GUIDs[i] = line[0];
                s_Instructions[i] = line[1];
                s_CamOffsets[i] = Int32.Parse(line[2]);
                s_URLs[i] = line.Length == 4 ? line[3] : null;
            }
        }

        private void LoadModels()
        {
            demoModels.items = new DemoModelSystem[s_GUIDs.Length];

            GameObject models = GameObject.FindWithTag("Models");
            
            for (int i = 0; i < demoModels.items.Length; i++)
            {
                DemoModelSystem container = new DemoModelSystem();
                container.transform = models.transform.Find(s_GUIDs[i]); // strict match - no space at the end!
                container.transform.name = (i + 1).ToString();
                demoModels.items[i] = container;
            }
        }

        [Serializable]
        public class DemoModelSystem
        {
            private static int defaultCamOffset = 5;
            private static string defaultInstructionText = "NO DESCRIPTION";
            
            public Transform transform;

            public int camOffset
            {
                get
                {
                    if (s_SelectedIndex >= s_CamOffsets.Length)
                    {
                        return defaultCamOffset;
                    }
                    return s_CamOffsets[s_SelectedIndex];
                }
                set
                {
                    if (s_SelectedIndex >= s_CamOffsets.Length)
                    {
                        return;
                    }
                    s_CamOffsets[s_SelectedIndex] = value;
                }
            }

            public Mode mode => Mode.Activate;
            
            public string instructionText
            {
                get
                {
                    if (s_SelectedIndex >= s_Instructions.Length)
                    {
                        return defaultInstructionText;
                    }
                    return s_Instructions[s_SelectedIndex];
                }
            }

            public string Url => s_URLs[s_SelectedIndex];
        }

        [Serializable]
        public class DemoModelSystemList
        {
            public DemoModelSystem[] items;
        }
    }
}