const char* BasicVertexShader = STRINGIFY(
/* Copyright (C) 2013 United States Government as represented by
the Administrator of the National Aeronautics and Space Administration.
All Rights Reserved.
*/

/*
 * OpenGL ES Shading Language v1.00 vertex shader for basic rendering. Transforms shape points from model coordinates
 * to eye coordinates.
 *
 * version $Id: BasicShader.vert 1471 2013-06-21 21:02:30Z dcollins $
 */

/*
 * Input vertex attribute defining the surface vertex point in model coordinates.
 */
attribute vec4 vertexPoint;
/*
 * Input uniform matrix defining the current modelview-projection transform matrix. Maps model coordinates to eye
 * coordinates.
 */
uniform mat4 mvpMatrix;

/*
 * OpenGL ES vertex shader entry point. Called for each vertex processed when this shader's program is bound.
 */
void main()
{
    /* Transform the shape vertex point from model coordinates to eye coordinates. */
    gl_Position = mvpMatrix * vertexPoint;
}
);