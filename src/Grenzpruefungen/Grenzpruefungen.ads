with ProduktionDatentypen;

package Grenzpruefungen is
   pragma Preelaborate;

   generic type GanzeZahl is range <>;

   function Standardprüfung
     (AktuellerWertExtern : in GanzeZahl;
      ÄnderungExtern : in GanzeZahl)
      return GanzeZahl;

   generic type KommaZahl is digits <>;

   function StandardKommamultiplikation
     (KommazahlEinsExtern : in KommaZahl;
      KommazahlZweiExtern : in KommaZahl)
      return KommaZahl;

   function Arbeitszeit
     (AktuellerWertExtern : in ProduktionDatentypen.Arbeitszeit;
      ÄnderungExtern : in ProduktionDatentypen.Arbeitszeit)
      return ProduktionDatentypen.Arbeitszeit;

   function Produktionsbonus
     (RessourcenbonusExtern : in ProduktionDatentypen.Produktionsbonus;
      VerbesserungsbonusExtern : in ProduktionDatentypen.Produktionsbonus;
      WegebonusExtern : in ProduktionDatentypen.Produktionsbonus;
      FlussbonusExtern : in ProduktionDatentypen.Produktionsbonus;
      FeldeffektmalusExtern : in ProduktionDatentypen.Produktionsbonus)
      return ProduktionDatentypen.Produktionsbonus;

end Grenzpruefungen;
