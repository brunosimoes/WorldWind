/*
 * Copyright (C) 2012 United States Government as represented by the Administrator of the
 * National Aeronautics and Space Administration.
 * All Rights Reserved.
 *
 * OpenGL ES Shading Language v1.00 fragment shader for rendering a shape with a uniform color. Displays each fragment
 * in the color specified by the uniform variable named 'color'.
 *
 * version $Id: BasicColorShader.frag 775 2012-09-14 22:11:44Z dcollins $
 */
precision mediump float;

/*
 * Input uniform vec4 defining the current color. Every fragment rasterized by this fragment shader is displayed in this
 * color.
 */
uniform vec4 color;

/*
 * OpenGL ES fragment shader entry point. Called for each fragment processed when this shader's program is bound.
 */
void main()
{
    gl_FragColor = color;
}
