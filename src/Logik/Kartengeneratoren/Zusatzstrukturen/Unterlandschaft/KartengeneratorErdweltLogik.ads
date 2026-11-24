private with SystemDatentypenHTSEB;
private with ZahlenRecordsHTSEB;

with KartenDatentypen;
with KartenRecords;

private with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorErdweltLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure KartengeneratorErdwelt
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
      
   Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Land_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
      
   type Umwandlung_Enum is (Erde_Enum, Erdgestein_Enum, Sand_Enum, Gestein_Enum);
   
   WelcherGrund : Umwandlung_Enum;
   
   type GrundwahrscheinlichkeitenArray is array (Umwandlung_Enum'Range) of ZahlenRecordsHTSEB.WahrscheinlichkeitsbereichRecord;
   Grundwahrscheinlichkeiten : GrundwahrscheinlichkeitenArray := (
                                                                  Erde_Enum       => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                  Erdgestein_Enum => (25, 29),
                                                                  Sand_Enum       => (50, 74),
                                                                  Gestein_Enum    => (75, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                 );
   
   type BasisgrundumwandlungArray is array (GrundwahrscheinlichkeitenArray'Range) of KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Land_Enum;
   Basisgrundumwandlung : constant BasisgrundumwandlungArray := (
                                                                 Erde_Enum       => KartenbasisgrundDatentypen.Erde_Enum,
                                                                 Erdgestein_Enum => KartenbasisgrundDatentypen.Erdgestein_Enum,
                                                                 Sand_Enum       => KartenbasisgrundDatentypen.Sand_Enum,
                                                                 Gestein_Enum    => KartenbasisgrundDatentypen.Gestein_Enum
                                                                );

end KartengeneratorErdweltLogik;
