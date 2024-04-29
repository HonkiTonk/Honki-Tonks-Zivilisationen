with Sf;

package TextaccesseSchriftgroesseGrafik is
   pragma Elaborate_Body;

   procedure SchriftgrößeSetzen
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32);

   procedure Texthöhen
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32);

private

   procedure Allgemeines
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32);

   procedure Menüs
     (StandardExtern : in Sf.sfUint32);

   procedure Spezies
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32);

   procedure ZusatztextKartengröße
     (StandardExtern : in Sf.sfUint32);

   procedure Sprachauswahl
     (StandardExtern : in Sf.sfUint32);

   procedure StadtInformationen
     (StandardExtern : in Sf.sfUint32);

   procedure EinheitenInformationen
     (StandardExtern : in Sf.sfUint32);

   procedure KarteWichtiges
     (StandardExtern : in Sf.sfUint32);

   procedure KarteAllgemeines
     (StandardExtern : in Sf.sfUint32);

   procedure Karte
     (ÜberschriftExtern : in Sf.sfUint32);

   procedure EinheitStadtAuswahl
     (StandardExtern : in Sf.sfUint32);

   procedure AnzeigeEingabe
     (StandardExtern : in Sf.sfUint32);

   procedure Ladezeiten
     (StandardExtern : in Sf.sfUint32);

   procedure Befehle
     (StandardExtern : in Sf.sfUint32);

end TextaccesseSchriftgroesseGrafik;
