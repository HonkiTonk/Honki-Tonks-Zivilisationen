with TextDatentypen;

with TexteinstellungenGrafik;
with TextaccesseSchriftgroesseGrafik;
with TextaccesseSchriftfarbeGrafik;
with TextaccesseSchriftstilGrafik;
with TextaccesseTextGrafik;

-- In allen Bereichen immer alles gleich anlegen, auch dann wenn es dann leer ist.
-- So weiß ich immer ob ich alles durchgegangen bin.
-- Schriftart wird hier nicht mehr gesetzt, damit das System mit verschiedenen Fonts klarkommt, siehe dazu auch TexteinstellungenGrafik.SchriftartFestlegen.
package body TextaccesseSetzenGrafik is
   
   procedure Abstandstext
   is begin
      
      null;
      
   end Abstandstext;
   
   
   
   procedure Schriftgröße
   is begin
      
      TextaccesseSchriftgroesseGrafik.SchriftgrößeSetzen (ÜberschriftExtern => TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum),
                                                            StandardExtern    => TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum),
                                                            KleinExtern       => TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Klein_Enum));
      
   end Schriftgröße;
   
   
     
   procedure Schriftfarbe
   is begin
      
      TextaccesseSchriftfarbeGrafik.SchriftfarbeSetzen (ÜberschriftExtern => TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Überschrift_Enum),
                                                        StandardExtern    => TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum),
                                                        SonstigeExtern    => TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Sonstiges_Enum));
      
   end Schriftfarbe;
   
   
     
   procedure Schriftstil
   is begin
      
      TextaccesseSchriftstilGrafik.SchriftstilSetzen (TexteinstellungenGrafik.SchriftstilLesen);
      
   end Schriftstil;
   
   
     
   procedure Text
   is begin
      
      TextaccesseTextGrafik.TextSetzen;
      
   end Text;

end TextaccesseSetzenGrafik;
