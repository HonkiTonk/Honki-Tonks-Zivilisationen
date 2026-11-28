private with SystemDatentypenHTSEB;
private with ZahlenRecordsHTSEB;

private with KartenbasisgrundDatentypen;
private with KartenRecords;

private with Contracts;

package KartengeneratorKernlandschaftLogik is
   pragma Elaborate_Body;

   procedure Landschaft
     (LadezeitbasisExtern : in Float)
     with
       Pre => (
                 LadezeitbasisExtern > 0.00
               and
                 LadezeitbasisExtern <= 100.00
              );
   
private
   
   AktuellerGrund : KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Enum;
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   
   type Umwandlung_Enum is (Ringwoodit_Enum, Majorit_Enum, Perowskit_Enum, Magnesiowüstit_Enum);
   
   WelcherGrund : Umwandlung_Enum;
   
   type GrundwahrscheinlichkeitenArray is array (Umwandlung_Enum'Range) of ZahlenRecordsHTSEB.WahrscheinlichkeitsbereichRecord;
   Grundwahrscheinlichkeiten : GrundwahrscheinlichkeitenArray := (
                                                                  Ringwoodit_Enum     => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                  Majorit_Enum        => (25, 50),
                                                                  Perowskit_Enum      => (51, 75),
                                                                  Magnesiowüstit_Enum => (76, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                 );
   
   type BasisgrundumwandlungArray is array (GrundwahrscheinlichkeitenArray'Range) of KartenbasisgrundDatentypen.Basisgrund_Kernfläche_Enum;
   Basisgrundumwandlung : constant BasisgrundumwandlungArray := (
                                                                 Ringwoodit_Enum     => KartenbasisgrundDatentypen.Ringwoodit_Enum,
                                                                 Majorit_Enum        => KartenbasisgrundDatentypen.Majorit_Enum,
                                                                 Perowskit_Enum      => KartenbasisgrundDatentypen.Perowskit_Enum,
                                                                 Magnesiowüstit_Enum => KartenbasisgrundDatentypen.Magnesiowüstit_Enum
                                                                );
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (Contracts.VorhandeneKoordinatenprüfung (KoordinatenExtern => KoordinatenExtern));
   
end KartengeneratorKernlandschaftLogik;
