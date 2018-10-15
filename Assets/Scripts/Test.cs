using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour {

	// Use this for initialization
	public Camera mainCam;
	Vector3 worldSpace;
	Vector3 viewSpace;
	public Vector4 projSpace;
	Vector3 ndcSpace;
	Vector2 textureSpace;

	void Start () {
		worldSpace = new Vector3 ();
		viewSpace = new Vector3 ();
		projSpace = new Vector4 ();
		ndcSpace = new Vector3 ();
		textureSpace = new Vector2 ();

	}

	void Update () {
		Matrix4x4 worldSpaceMatrix = transform.localToWorldMatrix;
		Matrix4x4 viewMatrix = mainCam.worldToCameraMatrix;
		Matrix4x4 projMatrix = mainCam.projectionMatrix;

		Matrix4x4 WS_mat = worldSpaceMatrix;
		worldSpace = new Vector3(WS_mat.m03,WS_mat.m13,WS_mat.m23);

		Matrix4x4 VS_mat = viewMatrix * transform.localToWorldMatrix;
		viewSpace = new Vector3(VS_mat.m03,VS_mat.m13,VS_mat.m23);

		Matrix4x4 PS_mat = projMatrix * viewMatrix * transform.localToWorldMatrix;
		projSpace = new Vector4(PS_mat.m03,PS_mat.m13,PS_mat.m23,PS_mat.m33);
		
		

		// Homogeneous divide x/w , y/w, z/w
		// Normalized Device Coordinate [ -1 to 1 ]
		// x/w, y/w, z/w
		ndcSpace = new Vector3(PS_mat.m03/PS_mat.m33,PS_mat.m13/PS_mat.m33,PS_mat.m23/PS_mat.m33);


		//textureSpacePos = float2(pos.x, pos.y);
		
		// NDC to texture space [ i.e. [-1, 1] to [0,1]
		// |--------|--------|  = NDC
		// -1       0        1
		
		//          |--------|--------|  = NDC + 1
		// -1       0        1        2
		
		//          |--------|           = (NDC + 1)/2
		// -1       0        1        2				
		textureSpace.x =  (ndcSpace.x + 1) * 0.5f;
		textureSpace.y =  (ndcSpace.y + 1) * 0.5f;

//		Debug.Log ("World Position" + " : " + worldSpace);
//		Debug.Log ("View Position" + " : " + viewSpace);
		Debug.Log ("Projection Position" + " : " + projSpace);
//		Debug.Log ("NDC Position" + " : " + ndcSpace);
//		Debug.Log ("Texture Space" + " : " + textureSpace);
	}
	
}
