with Sf.Graphics;

package TextaccesseSchriftartGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfFont_Ptr;

   procedure SchriftartSetzen
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

private

   procedure Allgemeines
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure Menüs
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure Spezies
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure ZusatztextKartengröße
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure Sprachauswahl
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure StadtInformationen
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure EinheitenInformationen
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure KarteWichtiges
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure KarteAllgemeines
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure Karte
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure EinheitStadtAuswahl
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure AnzeigeEingabe
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure Ladezeiten
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

   procedure Befehle
     (SchriftaccessExtern : in Sf.Graphics.sfFont_Ptr)
     with
       Pre => (
                 SchriftaccessExtern /= null
              );

end TextaccesseSchriftartGrafik;
