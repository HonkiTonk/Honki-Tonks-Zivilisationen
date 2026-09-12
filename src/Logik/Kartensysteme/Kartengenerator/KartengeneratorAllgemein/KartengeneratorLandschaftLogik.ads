private with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenzusatzgrundDatentypen;
private with KartenRecords;
private with KartenbasisgrundDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorLandschaftLogik is
   pragma Elaborate_Body;

   procedure GenerierungLandschaft;

private
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
      
   Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Enum;
   Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;
   WelcherGrund : SystemDatentypenHTSEB.NullBisHundert;

   LadezeitBasis : Float;
         
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   type BasisWahrscheinlichkeitenArray is array (SystemDatentypenHTSEB.EinsBisHundert'First .. 5) of SystemDatentypenHTSEB.NullBisHundert;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  1 => 50,
                                                                  2 => 15,
                                                                  3 => 15,
                                                                  4 => 15,
                                                                  5 => 15
                                                                 );
   
   type ZahlenNachBasisgrundArray is array (BasisWahrscheinlichkeitenArray'Range) of KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   ZahlenNachBasisgrund : constant ZahlenNachBasisgrundArray := (
                                                                 1 => KartenbasisgrundDatentypen.Flachland_Enum,
                                                                 2 => KartenbasisgrundDatentypen.Wüste_Enum,
                                                                 3 => KartenbasisgrundDatentypen.Tundra_Enum,
                                                                 4 => KartenbasisgrundDatentypen.Hügel_Enum,
                                                                 5 => KartenbasisgrundDatentypen.Gebirge_Enum
                                                                );
   
   type ZusatzWahrscheinlichkeitenArray is array (SystemDatentypenHTSEB.EinsBisHundert'First .. 3) of SystemDatentypenHTSEB.NullBisHundert;
   ZusatzWahrscheinlichkeiten : ZusatzWahrscheinlichkeitenArray := (
                                                                    1 => 40,
                                                                    2 => 30,
                                                                    3 => 30
                                                                   );
   
   type ZahlenNachZusatzgrundArray is array (0 .. ZusatzWahrscheinlichkeitenArray'Last) of KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   ZahlenNachZusatzgrund : constant ZahlenNachZusatzgrundArray := (
                                                                   0 => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                                                   1 => KartenzusatzgrundDatentypen.Wald_Enum,
                                                                   2 => KartenzusatzgrundDatentypen.Dschungel_Enum,
                                                                   3 => KartenzusatzgrundDatentypen.Sumpf_Enum
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
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
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
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
          and
            KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
         );
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Flachland_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
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

end KartengeneratorLandschaftLogik;
