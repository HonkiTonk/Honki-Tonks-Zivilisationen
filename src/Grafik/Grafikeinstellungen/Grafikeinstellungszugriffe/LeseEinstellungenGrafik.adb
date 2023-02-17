with EinstellungenGrafik;

package body LeseEinstellungenGrafik is
   
   -- Fenstereinstellungen
   function Fenstermodus
     return Sf.Window.Window.sfWindowStyle
   is begin
      
      return EinstellungenGrafik.FensterEinstellungen.Fenstermodus;
      
   end Fenstermodus;
   
   
   
   function Auflösung
     return Sf.System.Vector2.sfVector2u
   is begin
      
      return EinstellungenGrafik.FensterEinstellungen.Auflösung;
      
   end Auflösung;
   
   
   
   function Farbtiefe
     return Sf.sfUint32
   is begin
      
      return EinstellungenGrafik.FensterEinstellungen.Farbtiefe;
      
   end Farbtiefe;
   
   
   
   function Bildrate
     return Sf.sfUint32
   is begin
      
      return EinstellungenGrafik.FensterEinstellungen.Bildrate;
      
   end Bildrate;
   -- Fenstereinstellungen
   
   
   
   -- Grafikeinstellungen
   function EbenenUnterhalbSichtbar
     return Boolean
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar;
      
   end EbenenUnterhalbSichtbar;
   -- Grafikeinstellungen
   
   
   
   function Fenstereinstellungen
     return GrafikRecords.FensterRecord
   is begin
      
      return EinstellungenGrafik.FensterEinstellungen;
      
   end Fenstereinstellungen;
   
   
   
   function Grafikeinstellungen
     return GrafikRecords.GrafikeinstellungenRecord
   is begin
      
      return EinstellungenGrafik.Grafikeinstellungen;
      
   end Grafikeinstellungen;

end LeseEinstellungenGrafik;
