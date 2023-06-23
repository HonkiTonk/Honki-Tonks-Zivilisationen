with ProduktionKonstanten;

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
   
   
   
   function StandardKommamultiplikation
     (KommazahlEinsExtern : in KommaZahl;
      KommazahlZweiExtern : in KommaZahl)
      return KommaZahl
   is begin
      
      if
        Float (KommazahlEinsExtern) * Float (KommazahlZweiExtern) >= Float (KommaZahl'Last)
      then
         return KommaZahl'Last;
         
         -- Sollte aktuell nie auftreten da alle Kommazahlen größer Null sind, aber das kann sich in der Zukunft ja ändern.
      elsif
        Float (KommazahlEinsExtern) * Float (KommazahlZweiExtern) <= Float (KommaZahl'First)
      then
         return KommaZahl'First;
         
      else
         return KommazahlEinsExtern * KommazahlZweiExtern;
      end if;
      
   end StandardKommamultiplikation;

   
   
   -- Kann nicht einfach in ein generic umgewandelt werden, da ja nicht der kleinste Wert sondern eins zurückgegeben wird.
   -- Eventuell gibt es dafür auch eine schöne Lösung? äöü
   -- Man könnte das Minimum auch mitübergeben. äöü
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
        AktuellerWertExtern + ÄnderungExtern <= ProduktionKonstanten.MinimaleArbeitszeit
      then
         return ProduktionKonstanten.MinimaleArbeitszeit;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end Arbeitszeit;

end Grenzpruefungen;
