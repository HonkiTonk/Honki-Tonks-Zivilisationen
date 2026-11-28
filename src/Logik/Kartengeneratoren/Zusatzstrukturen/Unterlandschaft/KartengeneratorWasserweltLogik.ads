private with SystemDatentypenHTSEB;
private with ZahlenRecordsHTSEB;

with KartenDatentypen;
with KartenRecords;
with KartenartDatentypen;

private with KartenzusatzgrundDatentypen;
private with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorWasserweltLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
         
   Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Enum;
   
   Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   
   type Wasserumwandlung_Enum is (Leer_Enum, Korallen_Enum, Unterwald_Enum);
   Wasserzusatz : Wasserumwandlung_Enum;
   
   type WassergrundwahrscheinlichkeitenArray is array (KartenartDatentypen.Kartentemperatur_Enum, Wasserumwandlung_Enum'Range) of ZahlenRecordsHTSEB.WahrscheinlichkeitsbereichRecord;
   Wassergrundwahrscheinlichkeiten : WassergrundwahrscheinlichkeitenArray := (
                                                                              KartenartDatentypen.Eiszeit_Enum =>
                                                                                (
                                                                                 Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 33),
                                                                     
                                                                                 Korallen_Enum  => (34, 66),
                                                                                 Unterwald_Enum => (67, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                                ),
                                                                  
                                                                              KartenartDatentypen.Kalt_Enum =>
                                                                                (
                                                                                 Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 33),
                                                                     
                                                                                 Korallen_Enum  => (34, 66),
                                                                                 Unterwald_Enum => (67, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                                ),
                                                                  
                                                                              KartenartDatentypen.Gemäßigt_Enum => 
                                                                                (
                                                                                 Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 33),
                                                                     
                                                                                 Korallen_Enum  => (34, 66),
                                                                                 Unterwald_Enum => (67, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                                ),
                                                                  
                                                                              KartenartDatentypen.Heiß_Enum =>
                                                                                (
                                                                                 Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 33),
                                                                     
                                                                                 Korallen_Enum  => (34, 66),
                                                                                 Unterwald_Enum => (67, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                                ),
                                                                  
                                                                              KartenartDatentypen.Warmzeit_Enum =>
                                                                                (
                                                                                 Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 33),
                                                                     
                                                                                 Korallen_Enum  => (34, 66),
                                                                                 Unterwald_Enum => (67, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                                )
                                                                             );
   
   type WasserumwandlungArray is array (Korallen_Enum .. WassergrundwahrscheinlichkeitenArray'Last (2)) of KartenzusatzgrundDatentypen.Zusatzgrund_Unterfläche_Enum;
   Wasserumwandlung : constant WasserumwandlungArray := (
                                                         Korallen_Enum  => KartenzusatzgrundDatentypen.Korallen_Enum,
                                                         Unterwald_Enum => KartenzusatzgrundDatentypen.Unterwald_Enum
                                                        );
     
   
        
   function Wasserbestimmung
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
     return KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
end KartengeneratorWasserweltLogik;
