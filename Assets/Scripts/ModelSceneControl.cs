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

        public DemoModelSystemList demoModels;
        public bool clearOnChange = false;
        public bool mouseWheelZoom = false;
        public Text titleText;
        public Transform sceneCamera;
        public Text instructionText;
        public Button previousButton;
        public Button nextButton;


        private List<Transform> m_CurrentModelList = new List<Transform>();
        private static int s_SelectedIndex = 0;
        private static string[] s_Instructions;
        private Vector3 m_CamOffsetVelocity = Vector3.zero;
        private Vector3 m_LastPos;
        public static DemoModelSystem s_Selected;


        private void Awake()
        {
            LoadInstructions();
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
            TextAsset ta = Resources.Load("Instructions") as TextAsset;
            s_Instructions = ta.text.Split('\n');
        }

        [Serializable]
        public class DemoModelSystem
        {
            public Transform transform;
            public Mode mode;
            public int camOffset = 15;
            
            public string instructionText
            {
                get { return s_Instructions[s_SelectedIndex]; }
            }
        }

        [Serializable]
        public class DemoModelSystemList
        {
            public DemoModelSystem[] items;
        }
    }
}