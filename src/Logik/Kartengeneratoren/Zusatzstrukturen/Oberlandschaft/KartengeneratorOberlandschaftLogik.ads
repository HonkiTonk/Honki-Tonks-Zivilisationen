private with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenRecords;
private with KartenbasisgrundDatentypen;
private with KartenartDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorOberlandschaftLogik is
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
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   Temperatur : KartenartDatentypen.Kartentemperatur_Enum;
         
   Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Enum;
   
   GezogeneZahl : SystemDatentypenHTSEB.NullBisHundert;
   WelcherGrund : SystemDatentypenHTSEB.NullBisHundert;
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;
         
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   -- Später auslagern oder durch etwas ersetzen das bereits ausgelagert ist. äöü
   type WahrscheinlichkeitsbereichRecord is record
      
      Anfangswahrscheinlichkeit : SystemDatentypenHTSEB.NullBisHundert;
      Endwahrscheinlichkeit : SystemDatentypenHTSEB.NullBisHundert;
      
   end record;
   
   -- Arktisch_Enum, Tundra_Enum, Grasland_Enum, Steppe_Enum, Savanne_Enum, Wüste_Enum, Hügel_Enum, Gebirge_Enum
   type GrundwahrscheinlichkeitenArray is array (KartenartDatentypen.Kartentemperatur_Enum, SystemDatentypenHTSEB.EinsBisHundert'First .. 8) of WahrscheinlichkeitsbereichRecord;
   Grundwahrscheinlichkeiten : GrundwahrscheinlichkeitenArray := (
                                                                  KartenartDatentypen.Eiszeit_Enum =>
                                                                    (
                                                                     1 => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                     2 => (25, 50),
                                                                     3 => (51, 70),
                                                                     4 => (71, 80),
                                                                     5 => (81, 83),
                                                                     6 => (84, 84),
                                                                     
                                                                     7 => (81, 90),
                                                                     8 => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Kalt_Enum =>
                                                                    (
                                                                     1 => (SystemDatentypenHTSEB.NullBisHundert'First, 10),
                                                                     2 => (11, 20),
                                                                     3 => (21, 50),
                                                                     4 => (51, 60),
                                                                     5 => (61, 70),
                                                                     6 => (71, 80),
                                                                     
                                                                     7 => (81, 90),
                                                                     8 => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Gemäßigt_Enum => 
                                                                    (
                                                                     1 => (SystemDatentypenHTSEB.NullBisHundert'First, 10),
                                                                     2 => (11, 20),
                                                                     3 => (21, 50),
                                                                     4 => (51, 60),
                                                                     5 => (61, 70),
                                                                     6 => (71, 80),
                                                                     
                                                                     7 => (81, 90),
                                                                     8 => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Heiß_Enum =>
                                                                    (
                                                                     1 => (SystemDatentypenHTSEB.NullBisHundert'First, 10),
                                                                     2 => (11, 20),
                                                                     3 => (21, 50),
                                                                     4 => (51, 60),
                                                                     5 => (61, 70),
                                                                     6 => (71, 80),
                                                                     
                                                                     7 => (81, 90),
                                                                     8 => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Warmzeit_Enum =>
                                                                    (
                                                                     1 => (SystemDatentypenHTSEB.NullBisHundert'First, 10),
                                                                     2 => (11, 20),
                                                                     3 => (21, 50),
                                                                     4 => (51, 60),
                                                                     5 => (61, 70),
                                                                     6 => (71, 80),
                                                                     
                                                                     7 => (81, 90),
                                                                     8 => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    )
                                                                 );
   
   type ZahlenNachBasisgrundArray is array (GrundwahrscheinlichkeitenArray'Range (2)) of KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   ZahlenNachBasisgrund : constant ZahlenNachBasisgrundArray := (
                                                                 1 => KartenbasisgrundDatentypen.Arktisch_Enum,
                                                                 2 => KartenbasisgrundDatentypen.Tundra_Enum,
                                                                 3 => KartenbasisgrundDatentypen.Grasland_Enum,
                                                                 4 => KartenbasisgrundDatentypen.Steppe_Enum,
                                                                 5 => KartenbasisgrundDatentypen.Savanne_Enum,
                                                                 6 => KartenbasisgrundDatentypen.Wüste_Enum,
                                                                 7 => KartenbasisgrundDatentypen.Hügel_Enum,
                                                                 8 => KartenbasisgrundDatentypen.Gebirge_Enum
                                                                );
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   
   
   function Zusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Arktisch
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

end KartengeneratorOberlandschaftLogik;
