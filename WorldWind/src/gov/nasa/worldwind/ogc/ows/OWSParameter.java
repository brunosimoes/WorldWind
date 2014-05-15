/*
 * Copyright (C) 2014 United States Government as represented by the Administrator of the
 * National Aeronautics and Space Administration.
 * All Rights Reserved.
 */

package gov.nasa.worldwind.ogc.ows;

import gov.nasa.worldwind.util.xml.*;

import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.XMLEvent;
import java.util.*;

/**
 * @author tag
 * @version $Id: OWSParameter.java 1981 2014-05-08 03:59:04Z tgaskins $
 */
public class OWSParameter extends AbstractXMLEventParser
{
    protected Set<OWSAllowedValues> allowedValues = new HashSet<OWSAllowedValues>(1);

    public OWSParameter(String namespaceURI)
    {
        super(namespaceURI);
    }

    public String getName()
    {
        return (String) this.getField("name");
    }

    public Set<OWSAllowedValues> getAllowedValues()
    {
        return this.allowedValues;
    }

    protected void doParseEventContent(XMLEventParserContext ctx, XMLEvent event, Object... args)
        throws XMLStreamException
    {
        if (ctx.isStartElement(event, "AllowedValues"))
        {
            XMLEventParser parser = this.allocate(ctx, event);
            if (parser != null)
            {
                Object o = parser.parse(ctx, event, args);
                if (o != null && o instanceof OWSAllowedValues)
                    this.allowedValues.add((OWSAllowedValues) o);
            }
        }
        else
        {
            super.doParseEventContent(ctx, event, args);
        }
    }
}
