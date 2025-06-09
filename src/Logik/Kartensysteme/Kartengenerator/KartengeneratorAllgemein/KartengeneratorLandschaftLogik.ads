private with AllgemeineBerechnungenHTSEB;
private with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartengrundDatentypen;
private with KartenRecords;

private with LeseWeltkarteneinstellungen;

package KartengeneratorLandschaftLogik is
   pragma Elaborate_Body;

   procedure GenerierungLandschaft;

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;
      
   Basisgrund : KartengrundDatentypen.Basisgrund_Enum;
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   Zahlenspeicher : SystemDatentypenHTSEB.NullBisHundert;
   WelcherGrund : SystemDatentypenHTSEB.NullBisHundert;
         
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   type BasisWahrscheinlichkeitenArray is array (SystemDatentypenHTSEB.EinsBisHundert'First .. 5) of SystemDatentypenHTSEB.NullBisHundert;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  1 => 50,
                                                                  2 => 15,
                                                                  3 => 15,
                                                                  4 => 15,
                                                                  5 => 15
                                                                 );
   
   type ZahlenNachBasisgrundArray is array (BasisWahrscheinlichkeitenArray'Range) of KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   ZahlenNachBasisgrund : constant ZahlenNachBasisgrundArray := (
                                                                 1 => KartengrundDatentypen.Flachland_Enum,
                                                                 2 => KartengrundDatentypen.Wüste_Enum,
                                                                 3 => KartengrundDatentypen.Tundra_Enum,
                                                                 4 => KartengrundDatentypen.Hügel_Enum,
                                                                 5 => KartengrundDatentypen.Gebirge_Enum
                                                                );
   
   type ZusatzWahrscheinlichkeitenArray is array (SystemDatentypenHTSEB.EinsBisHundert'First .. 3) of SystemDatentypenHTSEB.NullBisHundert;
   ZusatzWahrscheinlichkeiten : ZusatzWahrscheinlichkeitenArray := (
                                                                    1 => 40,
                                                                    2 => 30,
                                                                    3 => 30
                                                                   );
   
   type ZahlenNachZusatzgrundArray is array (0 .. ZusatzWahrscheinlichkeitenArray'Last) of KartengrundDatentypen.Zusatzgrund_Enum;
   ZahlenNachZusatzgrund : constant ZahlenNachZusatzgrundArray := (
                                                                   0 => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                                                   1 => KartengrundDatentypen.Wald_Enum,
                                                                   2 => KartengrundDatentypen.Dschungel_Enum,
                                                                   3 => KartengrundDatentypen.Sumpf_Enum
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
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
      
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Tundra_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Wüste_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Hügel_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Gebirge_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
          and
            KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
         );
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Flachland_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Wald_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Dschungel_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Sumpf_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorLandschaftLogik;
