/*
 * Copyright (C) 2011 United States Government as represented by the Administrator of the
 * National Aeronautics and Space Administration.
 * All Rights Reserved.
 */
package gov.nasa.worldwind.terrain;

import android.graphics.Point;
import gov.nasa.worldwind.geom.Sector;
import gov.nasa.worldwind.render.DrawContext;

import java.util.List;

/**
 * @author dcollins
 * @version $Id: SectorGeometryList.java 75 2011-09-29 17:06:26Z dcollins $
 */
public interface SectorGeometryList extends List<SectorGeometry>
{
    Sector getSector();

    void beginRendering(DrawContext dc);

    void endRendering(DrawContext dc);

    void pick(DrawContext dc, Point pickPoint);
}
