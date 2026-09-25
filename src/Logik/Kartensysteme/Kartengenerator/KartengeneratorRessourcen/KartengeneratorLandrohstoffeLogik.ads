with KartenDatentypen;
with KartenRecords;

private with KartenrohstoffeDatentypen;
private with KartenzusatzgrundDatentypen;
private with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorLandrohstoffeLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure Landrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   Rohstoff : KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   type ErlaubteRohstoffeArray is array (KartenbasisgrundDatentypen.Basisgrund_Gesamtoberfläche_Land_Enum'Range, KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of Boolean;
   ErlaubteRohstoffe : constant ErlaubteRohstoffeArray := (
                                                           KartenbasisgrundDatentypen.Basisgrund_Eis_Enum =>
                                                             (
                                                              KartenrohstoffeDatentypen.Algen_Enum                                   => True,
                                                              KartenrohstoffeDatentypen.Pilze_Enum                                   => True,
                                                              KartenrohstoffeDatentypen.Pinguine_Enum                                => True,
                                                              KartenrohstoffeDatentypen.Robben_Enum                                  => True,
                                                              KartenrohstoffeDatentypen.Krebse_Enum                                  => True,
                                                              KartenrohstoffeDatentypen.Vögel_Enum                                   => True,
                                                              KartenrohstoffeDatentypen.Wildtiere_Enum                               => True,
                                                              KartenrohstoffeDatentypen.Rohstoffe_Mineralien_Oberbegriffe_Enum'Range => True,
                                                              KartenrohstoffeDatentypen.Rohstoffe_Eis_Enum'Range                     => True,
                                                              others                                                                 => False
                                                             ),

                                                           KartenbasisgrundDatentypen.Basisgrund_Flachland_Enum'Range =>
                                                             (
                                                              others => True
                                                             ),

                                                           KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range =>
                                                             (
                                                              others => True
                                                             ),

                                                           KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum'Range =>
                                                             (
                                                              others => True
                                                             ),

                                                           KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
                                                             (
                                                              others => True
                                                             ),

                                                           KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
                                                             (
                                                              others => True
                                                             )
                                                          );

   procedure RohstoffMehrfach
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure RohstoffEinmal
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );



   function Basisgrund
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Boolean;

   function Zusatzgrund
     (ZusatzgrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Boolean;

   function RohstoffeVergleichen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorLandrohstoffeLogik;
