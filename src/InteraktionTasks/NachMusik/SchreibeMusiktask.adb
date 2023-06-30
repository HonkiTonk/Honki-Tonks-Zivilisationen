with Musiktask;

package body SchreibeMusiktask is

   procedure AktuelleMusik
     (MusikExtern : in TonDatentypen.Musik_Aktuelle_Auswahl_Enum)
   is begin
      
      Musiktask.AktuelleMusik := MusikExtern;
      
   end AktuelleMusik;

end SchreibeMusiktask;
