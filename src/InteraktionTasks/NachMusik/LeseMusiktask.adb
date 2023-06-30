with Musiktask;

package body LeseMusiktask is

   function AktuelleMusik
     return TonDatentypen.Musik_Aktuelle_Auswahl_Enum
   is begin
      
      return Musiktask.AktuelleMusik;
      
   end AktuelleMusik;

end LeseMusiktask;
