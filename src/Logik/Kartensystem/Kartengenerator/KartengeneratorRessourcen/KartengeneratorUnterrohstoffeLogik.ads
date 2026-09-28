with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenRecords;
private with KartenrohstoffeDatentypen;
private with KartenzusatzgrundDatentypen;
private with KartenbasisgrundDatentypen;
private with KartenfluesseDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorUnterrohstoffeLogik is
   pragma Elaborate_Body;

   procedure Rohstoffe
      (LadezeitbasisExtern : in SystemDatentypenHTSEB.LadezeitBasis);

private
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   RohstoffEinzigartig : Boolean;

   Rohstoff : KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;

   VorhandenerFluss : KartenfluesseDatentypen.Fluss_Enum;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   -- Diese Arrays mal irgendwohin verschieben wo sie besser hinpassen, eventuell eine neue Datenbank draus machen? äöü
   type BasisgrundRohstoffeArray is array (KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Enum'Range, KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of Boolean;
   BasisgrundRohstoffe : constant BasisgrundRohstoffeArray := (
                                                               KartenbasisgrundDatentypen.Meeresgrund_Enum =>
                                                                 (
                                                                  others => True
                                                                 ),

                                                               KartenbasisgrundDatentypen.Küstengrund_Enum =>
                                                                 (
                                                                  others => True
                                                                 ),

                                                               KartenbasisgrundDatentypen.Untereis_Enum =>
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

                                                               KartenbasisgrundDatentypen.Erde_Enum =>
                                                                 (
                                                                  others => True
                                                                 ),

                                                               KartenbasisgrundDatentypen.Erdgestein_Enum =>
                                                                 (
                                                                  others => True
                                                                 ),

                                                               KartenbasisgrundDatentypen.Sand_Enum =>
                                                                 (
                                                                  others => True
                                                                 ),

                                                               KartenbasisgrundDatentypen.Gestein_Enum =>
                                                                 (
                                                                  others => True
                                                                 )
                                                              );

   -- Hier muss ein nicht vorhandener Zusatzgrund mitbeachtet werden.
   type ZusatzgrundRohstoffeArray is array (KartenzusatzgrundDatentypen.Zusatzgrund_Unterfläche_Enum'Range, KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of Boolean;
   ZusatzgrundRohstoffe : constant ZusatzgrundRohstoffeArray := (
                                                                 KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum'Range =>
                                                                   (
                                                                    others => True
                                                                   ),

                                                                 KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum'Range =>
                                                                   (
                                                                    others => True
                                                                   )
                                                                );

   type FlussRohstoffeArray is array (KartenfluesseDatentypen.Fluss_Unterfläche_Enum'Range, KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of Boolean;
   FlussRohstoffe : constant FlussRohstoffeArray := (KartenfluesseDatentypen.Fluss_Unterfläche_Enum'Range =>
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

end KartengeneratorUnterrohstoffeLogik;
