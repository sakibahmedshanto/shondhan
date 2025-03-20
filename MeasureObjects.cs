using UnityEngine;
using TMPro;

public class MeasurementManager : MonoBehaviour
{
    public GameObject measurement; // Assign TextMesh Pro prefab in the Inspector
    public Transform[] measurableObjects; // Assign all windows or objects to measure in the Inspector
    
    // Adjust offset to position text correctly
    public Vector3 offset = new Vector3(0, 10f, 0.5f); // Move text higher (Y) and forward (Z)

    void Start()
    {
        foreach (Transform obj in measurableObjects)
        {
            if (measurement == null)
            {
                Debug.LogError("Measurement Text Prefab is not assigned!");
                return;
            }

            // Prevent duplicate text objects
            Transform existingText = obj.Find("MeasurementText");
            if (existingText != null)
            {
                Destroy(existingText.gameObject);
            }

            // Calculate position with offset
            Vector3 textPosition = obj.position + obj.TransformVector(offset);

            // Instantiate the text prefab
            GameObject textInstance = Instantiate(measurement, textPosition, Quaternion.identity);
            textInstance.name = "MeasurementText";
            textInstance.transform.SetParent(obj, true);

            // Align the text with the window properly
            textInstance.transform.rotation = obj.rotation; // Match window rotation
            textInstance.transform.Rotate(0, 180, 0); // Rotate to face outward

            // Adjust scale for better readability
            textInstance.transform.localScale = Vector3.one * 0.05f;

            // Get TextMeshPro component
            TextMeshPro tmpText = textInstance.GetComponent<TextMeshPro>();
            if (tmpText != null)
            {
                string dimensions = CalculateDimensions(obj);
                tmpText.text = !string.IsNullOrEmpty(dimensions) ? dimensions : "No Dimensions Found!";
                tmpText.fontSize = 30;
                tmpText.alignment = TextAlignmentOptions.Center;
                tmpText.color = Color.red;
            }
            else
            {
                Debug.LogError("TextMeshPro component not found on the prefab.");
            }
        }
    }

   string CalculateDimensions(Transform obj)
{
    Renderer renderer = obj.GetComponentInChildren<Renderer>();
    if (renderer != null)
    {
        Vector3 size = renderer.bounds.size;

        // Default values
        float widthAdjustment = 0;
        float heightAdjustment = 0;
        float thicknessAdjustment = 0;

        // Check object name or tag to modify values
        if (obj.name.Contains("Window"))
        {
            widthAdjustment = 2.0f;
            heightAdjustment = 3.0f;
            thicknessAdjustment = 0.1f;
        }
        else if (obj.name.Contains("Wall"))
        {
            widthAdjustment = 5.0f;
            heightAdjustment = 8.0f;
            thicknessAdjustment = 0.3f;
        }
        else if (obj.name.Contains("Door"))
        {
            widthAdjustment = 3.0f;
            heightAdjustment = 7.0f;
            thicknessAdjustment = 0.2f;
        }
        else
        {
            // Generic default for unclassified objects
            widthAdjustment = 1.0f;
            heightAdjustment = 1.0f;
            thicknessAdjustment = 0.1f;
        }

        // Apply adjustments
        return $"Width: {size.x + widthAdjustment:F2}ft\n" +
               $"Height: {size.y + heightAdjustment:F2}ft\n" +
               $"Thickness: {size.z + thicknessAdjustment:F2}m";
    }
    else
    {
        Debug.LogWarning($"No Renderer found for object: {obj.name}");
        return null;
    }
}

}