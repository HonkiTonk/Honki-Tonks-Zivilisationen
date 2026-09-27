with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenRecords;
private with KartenrohstoffeDatentypen;
private with KartenzusatzgrundDatentypen;
private with KartenbasisgrundDatentypen;
private with KartenfluesseDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorOberrohstoffeLogik is
   pragma Elaborate_Body;

   procedure Landrohstoffe
      (LadezeitbasisExtern : in SystemDatentypenHTSEB.LadezeitBasis);

private
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   RohstoffEinzigartig : Boolean;

   Rohstoff : KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;

   VorhandenerFluss : KartenfluesseDatentypen.Fluss_Enum;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   -- Diese Arrays mal irgendwohin verschieben wo sie besser hinpassen, eventuell eine neue Datenbank draus machen? äöü
   type BasisgrundRohstoffeArray is array (KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Enum'Range, KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of Boolean;
   BasisgrundRohstoffe : constant BasisgrundRohstoffeArray := (
                                                               KartenbasisgrundDatentypen.Meer_Enum =>
                                                                 (
                                                                  others => False
                                                                 ),

                                                               KartenbasisgrundDatentypen.Küstengewässer_Enum =>
                                                                 (
                                                                  others => False
                                                                 ),

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

   -- Hier muss ein nicht vorhandener Zusatzgrund mitbeachtet werden.
   type ZusatzgrundRohstoffeArray is array (KartenzusatzgrundDatentypen.Zusatzgrund_Enum'First .. KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum'Last,
                                            KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of Boolean;
   ZusatzgrundRohstoffe : constant ZusatzgrundRohstoffeArray := (
                                                                 KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum =>
                                                                   (
                                                                    others => True
                                                                   ),

                                                                 KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range =>
                                                                   (
                                                                    others => True
                                                                   ),

                                                                 KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum'Range =>
                                                                   (
                                                                    others => True
                                                                   ),

                                                                 KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum'Range =>
                                                                   (
                                                                    others => True
                                                                   )
                                                                );

   type FlussRohstoffeArray is array (KartenfluesseDatentypen.Leer_Fluss_Enum .. KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Last, KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of Boolean;
   FlussRohstoffe : constant FlussRohstoffeArray := (
                                                     KartenfluesseDatentypen.Leer_Fluss_Enum =>
                                                       (
                                                        others => False
                                                       ),

                                                     KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Range =>
                                                       (
                                                        KartenrohstoffeDatentypen.Fische_Enum => True,
                                                        others                                => False
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

end KartengeneratorOberrohstoffeLogik;
