with EinheitenKonstanten;

package body Grenzpruefungen is
   
   function Standardprüfung
     (AktuellerWertExtern : in GanzeZahl;
      ÄnderungExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= GanzeZahl'Last
      then
         return GanzeZahl'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= GanzeZahl'First
      then
         return GanzeZahl'First;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end Standardprüfung;

   
   
   -- Kann nicht einfach in ein generic umgewandelt werden, da ja nicht der kleinste Wert sondern eins zurückgegeben wird.
   -- Eventuell gibt es dafür auch eine schöne Lösung? äöü
   function Arbeitszeit
     (AktuellerWertExtern : in ProduktionDatentypen.Arbeitszeit;
      ÄnderungExtern : in ProduktionDatentypen.Arbeitszeit)
      return ProduktionDatentypen.Arbeitszeit
   is
      use type ProduktionDatentypen.Arbeitszeit;
   begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= ProduktionDatentypen.Arbeitszeit'Last
      then
         return ProduktionDatentypen.Arbeitszeit'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= EinheitenKonstanten.MinimaleArbeitszeit
      then
         return EinheitenKonstanten.MinimaleArbeitszeit;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end Arbeitszeit;

end Grenzpruefungen;
