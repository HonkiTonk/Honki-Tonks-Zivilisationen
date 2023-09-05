with EinstellungenGrafik;

package body LeseEinstellungenGrafik is
   
   function Fenstermodus
     return Sf.Window.Window.sfWindowStyle
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Fenstermodus;
      
   end Fenstermodus;
   
   
   
   function Auflösung
     return Sf.System.Vector2.sfVector2u
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Auflösung;
      
   end Auflösung;
   
   
   
   function Farbtiefe
     return Sf.sfUint32
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Farbtiefe;
      
   end Farbtiefe;
   
   
   
   function Bildrate
     return Sf.sfUint32
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Bildrate;
      
   end Bildrate;
   
   
   
   function VSync
     return Sf.sfBool
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.VSync;
      
   end VSync;
   
   
   
   function SpeziesfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.Speziesfarben (SpeziesExtern);
      
   end SpeziesfarbeLesen;
   
   
   
   function RahmenfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return (EinstellungenGrafik.Grafikeinstellungen.Speziesfarben (SpeziesExtern).r, EinstellungenGrafik.Grafikeinstellungen.Speziesfarben (SpeziesExtern).g,
              EinstellungenGrafik.Grafikeinstellungen.Speziesfarben (SpeziesExtern).b, GrafikKonstanten.Undurchsichtig);
      
   end RahmenfarbeLesen;
   
   
   
   function EbenenUnterhalbSichtbar
     return Boolean
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar;
      
   end EbenenUnterhalbSichtbar;
   
   
   
   function BildrateAnzeigen
     return Boolean
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.BildrateAnzeigen;
      
   end BildrateAnzeigen;

end LeseEinstellungenGrafik;
