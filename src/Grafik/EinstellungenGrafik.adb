with TexteinstellungenGrafik;
with SpezieseinstellungenGrafik;

package body EinstellungenGrafik is

   procedure StandardeinstellungenLaden
   is begin
      
      FensterEinstellungen := FensterStandardEinstellungen;
      Grafikeinstellungen := GrafikeinstellungenStandard;
            
      TexteinstellungenGrafik.StandardLaden;
      SpezieseinstellungenGrafik.StandardLaden;
      
   end StandardeinstellungenLaden;
   
   
   
   procedure FenstereinstellungenSchreiben
     (EintragExtern : in GrafikRecords.FensterRecord)
   is begin
      
      FensterEinstellungen := EintragExtern;
      
   end FenstereinstellungenSchreiben;
   
   
   
   procedure GrafikeinstellungenSchreiben
     (EintragExtern : in GrafikRecords.GrafikeinstellungenRecord)
   is begin
      
      Grafikeinstellungen := EintragExtern;
      
   end GrafikeinstellungenSchreiben;
   
   
   
   function FenstereinstellungenLesen
     return GrafikRecords.FensterRecord
   is begin
      
      return FensterEinstellungen;
      
   end FenstereinstellungenLesen;
   
   
   
   function GrafikeinstellungenLesen
     return GrafikRecords.GrafikeinstellungenRecord
   is begin
      
      return Grafikeinstellungen;
      
   end GrafikeinstellungenLesen;

end EinstellungenGrafik;
