package TextaccesseSchriftrahmenGrafik is
   pragma Elaborate_Body;

   procedure SchriftrahmenSetzen
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

private

   procedure Allgemeines
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure Menüs
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure Spezies
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure ZusatztextKartengröße
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure Sprachauswahl
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure StadtInformationen
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure EinheitenInformationen
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure KarteWichtiges
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure KarteAllgemeines
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure Karte
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure EinheitStadtAuswahl
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure AnzeigeEingabe
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure Ladezeiten
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

   procedure Befehle
     (RahmendickeExtern : in Float)
     with
       Pre => (
                 RahmendickeExtern >= 0.00
              );

end TextaccesseSchriftrahmenGrafik;
