pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TextaccesseSchriftartGrafik is
   pragma Elaborate_Body;

   procedure SchriftartSetzen;

private

   procedure Allgemeines;
   procedure Menüs;
   procedure Rassen;
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

end TextaccesseSchriftartGrafik;
