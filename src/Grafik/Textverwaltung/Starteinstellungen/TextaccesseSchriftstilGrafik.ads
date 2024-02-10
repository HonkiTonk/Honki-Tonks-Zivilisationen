with Sf.Graphics.Text;

package TextaccesseSchriftstilGrafik is
   pragma Elaborate_Body;
   use type Sf.sfUint32;

   procedure SchriftstilSetzen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );
   
   procedure Texthöhen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

private

   procedure Allgemeines
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure Menüs
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure Spezies
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure ZusatztextKartengröße
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure Sprachauswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure Kartenformauswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure StadtInformationen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure EinheitenInformationen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure KarteWichtiges
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure KarteAllgemeines
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure Karte
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure EinheitStadtAuswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure AnzeigeEingabe
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure Ladezeiten
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );

   procedure Befehle
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
     with
       Pre => (
                 StilExtern <= 8
              );
   
end TextaccesseSchriftstilGrafik;
