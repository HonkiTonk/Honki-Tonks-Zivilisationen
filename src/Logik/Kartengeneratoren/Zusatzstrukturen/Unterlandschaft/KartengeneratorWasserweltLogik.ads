private with SystemDatentypenHTSEB;

with KartenDatentypen;
with KartenRecords;

private with KartenzusatzgrundDatentypen;
private with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorWasserweltLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure KartengeneratorWasserwelt
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
         
   Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;
   WelcherGrund : SystemDatentypenHTSEB.NullBisHundert;
   
   type ZusatzWahrscheinlichkeitenArray is array (SystemDatentypenHTSEB.EinsBisHundert'First .. 2) of SystemDatentypenHTSEB.NullBisHundert;
   ZusatzWahrscheinlichkeiten : ZusatzWahrscheinlichkeitenArray := (
                                                                    1 => 30,
                                                                    2 => 30
                                                                   );
   
   type ZahlenNachZusatzgrundArray is array (0 .. ZusatzWahrscheinlichkeitenArray'Last) of KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   ZahlenNachZusatzgrund : constant ZahlenNachZusatzgrundArray := (
                                                                   0 => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                                                   1 => KartenzusatzgrundDatentypen.Korallen_Enum,
                                                                   2 => KartenzusatzgrundDatentypen.Unterwald_Enum
                                                                  );
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
     
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
         
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Unterfläche_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungMeeresgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungKorallen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungUnterwald
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorWasserweltLogik;
