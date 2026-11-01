private with SystemDatentypenHTSEB;

with KartenRecords;
with KartenDatentypen;

private with KartenzusatzgrundDatentypen;
private with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorZusatzlandschaftLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
     
private
      
   Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Enum;
   
   Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;
   WelcherGrund : SystemDatentypenHTSEB.NullBisHundert;
   
   type ZusatzWahrscheinlichkeitenArray is array (SystemDatentypenHTSEB.EinsBisHundert'First .. 4) of SystemDatentypenHTSEB.NullBisHundert;
   ZusatzWahrscheinlichkeiten : ZusatzWahrscheinlichkeitenArray := (
                                                                    1 => 40,
                                                                    2 => 30,
                                                                    3 => 30,
                                                                    4 => 15
                                                                   );
   
   type ZahlenNachZusatzgrundArray is array (0 .. ZusatzWahrscheinlichkeitenArray'Last) of KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   ZahlenNachZusatzgrund : constant ZahlenNachZusatzgrundArray := (
                                                                   0 => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                                                   1 => KartenzusatzgrundDatentypen.Wald_Enum,
                                                                   2 => KartenzusatzgrundDatentypen.Dschungel_Enum,
                                                                   3 => KartenzusatzgrundDatentypen.Sumpf_Enum,
                                                                   4 => KartenzusatzgrundDatentypen.Riffe_Enum
                                                                  );
   
   
   
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungRiffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorZusatzlandschaftLogik;
