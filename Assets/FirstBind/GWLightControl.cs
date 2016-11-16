using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class GWLightControl : MonoBehaviour {

	public Vector3 LightPosition;
	public Material[] UsedMaterials; 

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update ()
	{
		foreach(Material m in UsedMaterials)
		{
			//m.SetVector("_CharLightDir",LightPosition);
		}
	}
}
