with Sf.Graphics.Color;

package TextaccesseSchriftfarbeGrafik is
   pragma Elaborate_Body;

   procedure SchriftfarbeSetzen
     (ÜberschriftExtern : in Sf.Graphics.Color.sfColor;
      StandardExtern : in Sf.Graphics.Color.sfColor;
      SonstigeExtern : in Sf.Graphics.Color.sfColor);

private

   procedure Allgemeines
     (ÜberschriftExtern : in Sf.Graphics.Color.sfColor;
      StandardExtern : in Sf.Graphics.Color.sfColor;
      SonstigeExtern : in Sf.Graphics.Color.sfColor);

   procedure Menüs
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure Spezies
     (ÜberschriftExtern : in Sf.Graphics.Color.sfColor;
      StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure ZusatztextKartengröße
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure Sprachauswahl
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure Kartenformauswahl
     (ÜberschriftExtern : in Sf.Graphics.Color.sfColor;
      StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure StadtInformationen
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure EinheitenInformationen
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure KarteWichtiges
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure KarteAllgemeines
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure Karte
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure EinheitStadtAuswahl
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure AnzeigeEingabe
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure Ladezeiten
     (StandardExtern : in Sf.Graphics.Color.sfColor);

   procedure Befehle
     (StandardExtern : in Sf.Graphics.Color.sfColor);

end TextaccesseSchriftfarbeGrafik;
