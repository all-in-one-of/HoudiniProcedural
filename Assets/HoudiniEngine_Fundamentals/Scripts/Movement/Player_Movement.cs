using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class Player_Movement : MonoBehaviour 
{
    #region Variables
    [Header("Speed Properties")]
    public float m_Speed = 1f;
    public float m_SmoothSpeed = 2f;

    private Vector2 inputVec = Vector2.zero;
    private Rigidbody rb;
    private Vector3 finalMoveDir;
    #endregion


    #region Main Methods
	// Use this for initialization
	void Start () 
    {
        rb = GetComponent<Rigidbody>();
	}
	
	// Update is called once per frame
	void Update () 
    {
        HandleInputs();
	}

    void FixedUpdate()
    {
        if(rb)
        {
            HandleMovement();
        }
    }
    #endregion


    #region Custom Methods
    protected virtual void HandleInputs()
    {
        inputVec = new Vector2(Input.GetAxisRaw("Horizontal"), Input.GetAxisRaw("Vertical"));
        inputVec = inputVec.normalized * m_Speed * Time.deltaTime;
    }

    protected virtual void HandleMovement()
    {
        Vector3 moveDir = (transform.forward * inputVec.y) + (transform.right * inputVec.x);
        moveDir = moveDir.normalized * m_Speed * Time.deltaTime;
        finalMoveDir = Vector3.Lerp(finalMoveDir, moveDir, Time.deltaTime * m_SmoothSpeed);

        rb.MovePosition(transform.position + finalMoveDir);
    }
    #endregion
}
