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
   
   
   
   -- Die externen Werte eventuell noch prüfen ob sie kleiner als 0,01 sind und dann entsprechend auf 0,01 setzen? äöü
   function Produktionsbonus
     (RessourcenbonusExtern : in ProduktionDatentypen.Produktionsbonus;
      VerbesserungsbonusExtern : in ProduktionDatentypen.Produktionsbonus;
      WegebonusExtern : in ProduktionDatentypen.Produktionsbonus;
      FlussbonusExtern : in ProduktionDatentypen.Produktionsbonus;
      FeldeffektmalusExtern : in ProduktionDatentypen.Produktionsbonus)
      return ProduktionDatentypen.Produktionsbonus
   is
      use type ProduktionDatentypen.Produktionsbonus;
   begin
      
      if
        Float (RessourcenbonusExtern) * Float (VerbesserungsbonusExtern) * Float (WegebonusExtern) * Float (FlussbonusExtern) * Float (FeldeffektmalusExtern) > Float (ProduktionDatentypen.Produktionsbonus'Last)
      then
         return ProduktionDatentypen.Produktionsbonus'Last;
         
      else
         return (RessourcenbonusExtern * VerbesserungsbonusExtern * WegebonusExtern * FlussbonusExtern * FeldeffektmalusExtern);
      end if;
      
   end Produktionsbonus;

end Grenzpruefungen;
