with TextDatentypen;

with TexteinstellungenGrafik;
with TextaccesseSchriftgroesseGrafik;
with TextaccesseSchriftfarbeGrafik;
with TextaccesseSchriftstilGrafik;
with TextaccesseTextGrafik;

package body TextaccesseSetzenGrafik is
   
   procedure StandardSetzen
   is begin
      
      -- In allen Bereichen immer alles gleich anlegen, auch dann wenn es dann leer ist.
      -- So weiß ich immer ob ich alles durchgegangen bin.
      -- Schriftart wird hier nicht mehr gesetzt, damit das System mit verschiedenen Fonts klarkommt, siehe dazu auch TexteinstellungenGrafik.SchriftartFestlegen.
      TextaccesseSchriftgroesseGrafik.SchriftgrößeSetzen (ÜberschriftExtern => TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum),
                                                            StandardExtern    => TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum),
                                                            KleinExtern       => TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Klein_Enum));
      TextaccesseSchriftfarbeGrafik.SchriftfarbeSetzen (ÜberschriftExtern => TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Überschrift_Enum),
                                                        StandardExtern    => TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum),
                                                        SonstigeExtern    => TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Sonstiges_Enum));
      TextaccesseSchriftstilGrafik.SchriftstilSetzen (TexteinstellungenGrafik.SchriftstilLesen);
      TextaccesseTextGrafik.TextSetzen;
      
   end StandardSetzen;

end TextaccesseSetzenGrafik;
