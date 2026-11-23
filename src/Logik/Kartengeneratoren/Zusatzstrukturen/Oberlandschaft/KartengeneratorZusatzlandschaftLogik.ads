private with SystemDatentypenHTSEB;
private with ZahlenRecordsHTSEB;

with KartenRecords;
with KartenDatentypen;
with KartenartDatentypen;

private with KartenzusatzgrundDatentypen;
private with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorZusatzlandschaftLogik is
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
      
   Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Enum;
   
   Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   
   -- Brauche ich für denn Fall dass der Zusatzgrund für Wasserfelder erweitert werden soll.
   type Wasserumwandlung_Enum is (Leer_Enum, Riffe_Enum);
   Wasserzusatz : Wasserumwandlung_Enum;
   
   type WassergrundwahrscheinlichkeitenArray is array (Wasserumwandlung_Enum'Range) of ZahlenRecordsHTSEB.WahrscheinlichkeitsbereichRecord;
   Wassergrundwahrscheinlichkeiten : WassergrundwahrscheinlichkeitenArray := (
                                                                              Leer_Enum  => (SystemDatentypenHTSEB.NullBisHundert'First, 84),
                                                                              Riffe_Enum => (85, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                             );
   
   type WasserumwandlungArray is array (Riffe_Enum .. WassergrundwahrscheinlichkeitenArray'Last) of KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum;
   Wasserumwandlung : constant WasserumwandlungArray := (
                                                         Riffe_Enum => KartenzusatzgrundDatentypen.Riffe_Enum
                                                        );
   
   type Landumwandlung_Enum is (Leer_Enum, Wald_Enum, Dschungel_Enum, Sumpf_Enum);
   Landzusatz : Landumwandlung_Enum;
   
   type LandgrundwahrscheinlichkeitenArray is array (KartenartDatentypen.Kartentemperatur_Enum, Landumwandlung_Enum'Range) of ZahlenRecordsHTSEB.WahrscheinlichkeitsbereichRecord;
   Landgrundwahrscheinlichkeiten : LandgrundwahrscheinlichkeitenArray := (
                                                                          KartenartDatentypen.Eiszeit_Enum =>
                                                                            (
                                                                             Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                     
                                                                             Wald_Enum      => (25, 50),
                                                                             Dschungel_Enum => (51, 60),
                                                                             Sumpf_Enum     => (61, 76)
                                                                            ),
                                                                  
                                                                          KartenartDatentypen.Kalt_Enum =>
                                                                            (
                                                                             Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                     
                                                                             Wald_Enum      => (25, 50),
                                                                             Dschungel_Enum => (51, 60),
                                                                             Sumpf_Enum     => (61, 76)
                                                                            ),
                                                                  
                                                                          KartenartDatentypen.Gemäßigt_Enum => 
                                                                            (
                                                                             Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                     
                                                                             Wald_Enum      => (25, 50),
                                                                             Dschungel_Enum => (51, 60),
                                                                             Sumpf_Enum     => (61, 76)
                                                                            ),
                                                                  
                                                                          KartenartDatentypen.Heiß_Enum =>
                                                                            (
                                                                             Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                     
                                                                             Wald_Enum      => (25, 50),
                                                                             Dschungel_Enum => (51, 60),
                                                                             Sumpf_Enum     => (61, 76)
                                                                            ),
                                                                  
                                                                          KartenartDatentypen.Warmzeit_Enum =>
                                                                            (
                                                                             Leer_Enum      => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                     
                                                                             Wald_Enum      => (25, 50),
                                                                             Dschungel_Enum => (51, 60),
                                                                             Sumpf_Enum     => (61, 76)
                                                                            )
                                                                         );
   
   type LandumwandlungArray is array (Wald_Enum .. LandgrundwahrscheinlichkeitenArray'Last (2)) of KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum;
   Landumwandlung : constant LandumwandlungArray := (
                                                     Wald_Enum      => KartenzusatzgrundDatentypen.Wald_Enum,
                                                     Dschungel_Enum => KartenzusatzgrundDatentypen.Dschungel_Enum,
                                                     Sumpf_Enum     => KartenzusatzgrundDatentypen.Sumpf_Enum
                                                    );
   
   
   
   function Wasserbestimmung
     return KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   function Landbestimmung
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum;
      BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   function ZusatzExtraberechnungen
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   function ZusatzberechnungWald
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   function ZusatzberechnungDschungel
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   function ZusatzberechnungSumpf
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum;

end KartengeneratorZusatzlandschaftLogik;
