with Sf.Graphics.Color;

package TextaccesseSchriftfarbeGrafik is
   pragma Elaborate_Body;

   procedure SchriftfarbeSetzen;

private

   Überschriftfarbe : Sf.Graphics.Color.sfColor;
   Standardfarbe : Sf.Graphics.Color.sfColor;
   SonstigeFarbe : Sf.Graphics.Color.sfColor;

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

end TextaccesseSchriftfarbeGrafik;
