with Sf;

package TextaccesseSchriftgroesseGrafik is
   pragma Elaborate_Body;

   procedure SchriftgrößeSetzen;

private

   Überschrift : Sf.sfUint32;
   Normal : Sf.sfUint32;
   Klein : Sf.sfUint32;

   procedure Allgemeines;
   procedure Menüs;
   procedure Spezies;
   procedure ZusatztextKartengröße;
   procedure Sprachauswahl;
   procedure Kartenformauswahl;
   procedure StadtInformationen;
   procedure EinheitenInformationen;
   procedure KarteWichtiges;
   procedure KarteAllgemeines;
   procedure Karte;
   procedure EinheitStadtAuswahl;
   procedure AnzeigeEingabe;
   procedure Ladezeiten;
   procedure Befehle;

end TextaccesseSchriftgroesseGrafik;
