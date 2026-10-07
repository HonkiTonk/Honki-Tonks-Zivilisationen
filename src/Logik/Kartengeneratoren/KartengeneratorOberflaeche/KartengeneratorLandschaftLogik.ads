private with SystemDatentypenHTSEB;

private with KartenDatentypen;
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
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;
   WelcherGrund : SystemDatentypenHTSEB.NullBisHundert;

   LadezeitBasis : Float;
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;
         
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   type BasisWahrscheinlichkeitenArray is array (SystemDatentypenHTSEB.EinsBisHundert'First .. 8) of SystemDatentypenHTSEB.NullBisHundert;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  1 => 50,
                                                                  2 => 15,
                                                                  3 => 15,
                                                                  4 => 15,
                                                                  5 => 15,
                                                                  6 => 15,
                                                                  7 => 15,
                                                                  8 => 15
                                                                 );
   
   type ZahlenNachBasisgrundArray is array (BasisWahrscheinlichkeitenArray'Range) of KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   ZahlenNachBasisgrund : constant ZahlenNachBasisgrundArray := (
                                                                 1 => KartenbasisgrundDatentypen.Grasland_Enum,
                                                                 2 => KartenbasisgrundDatentypen.Wüste_Enum,
                                                                 3 => KartenbasisgrundDatentypen.Tundra_Enum,
                                                                 4 => KartenbasisgrundDatentypen.Hügel_Enum,
                                                                 5 => KartenbasisgrundDatentypen.Gebirge_Enum,
                                                                 6 => KartenbasisgrundDatentypen.Arktisch_Enum,
                                                                 7 => KartenbasisgrundDatentypen.Steppe_Enum,
                                                                 8 => KartenbasisgrundDatentypen.Savanne_Enum
                                                                );
   
   procedure BasisgrundBestimmen
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
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
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
   
   function ZusatzberechnungGrasland
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartengeneratorLandschaftLogik;
