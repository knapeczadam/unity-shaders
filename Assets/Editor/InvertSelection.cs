using System;
using UnityEngine;
using UnityEditor;
 
using System.Collections.Generic;
 
public class InvertSelection : ScriptableWizard {
 
 
	[MenuItem ("Selection/Invert")]
	static void static_InvertSelection() { 
 
		List< GameObject > oldSelection = new List< GameObject >();
		List< GameObject > newSelection = new List< GameObject >();
 
 
		foreach( GameObject obj in Selection.GetFiltered( typeof( GameObject ), SelectionMode.ExcludePrefab ) )
			oldSelection.Add( obj );
 
		foreach( GameObject obj in FindObjectsOfType( typeof( GameObject ) ) )
		{
			if ( !oldSelection.Contains( obj ) )
				newSelection.Add( obj );
		}
 
		Selection.objects = newSelection.ToArray();
 
	}
 
}