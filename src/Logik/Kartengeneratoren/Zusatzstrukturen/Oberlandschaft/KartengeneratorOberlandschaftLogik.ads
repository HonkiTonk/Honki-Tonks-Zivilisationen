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
   
   GrundÄnderungswert : Integer;
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;
         
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   -- Später auslagern oder durch etwas ersetzen das bereits ausgelagert ist. äöü
   type WahrscheinlichkeitsbereichRecord is record
      
      Anfangswahrscheinlichkeit : SystemDatentypenHTSEB.NullBisHundert;
      Endwahrscheinlichkeit : SystemDatentypenHTSEB.NullBisHundert;
      
   end record;
   
   type Umwandlung_Enum is (Arktisch_Enum, Tundra_Enum, Grasland_Enum, Steppe_Enum, Savanne_Enum, Wüste_Enum,
                            Hügel_Enum, Gebirge_Enum);
   
   WelcherGrund : Umwandlung_Enum;
   
   type GrundwahrscheinlichkeitenArray is array (KartenartDatentypen.Kartentemperatur_Enum, Umwandlung_Enum'Range) of WahrscheinlichkeitsbereichRecord;
   Grundwahrscheinlichkeiten : GrundwahrscheinlichkeitenArray := (
                                                                  KartenartDatentypen.Eiszeit_Enum =>
                                                                    (
                                                                     Arktisch_Enum => (SystemDatentypenHTSEB.NullBisHundert'First, 24),
                                                                     Tundra_Enum   => (25, 50),
                                                                     Grasland_Enum => (51, 60),
                                                                     Steppe_Enum   => (61, 76),
                                                                     Savanne_Enum  => (77, 79),
                                                                     Wüste_Enum    => (80, 80),
                                                                     
                                                                     Hügel_Enum    => (81, 90),
                                                                     Gebirge_Enum  => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Kalt_Enum =>
                                                                    (
                                                                     Arktisch_Enum => (SystemDatentypenHTSEB.NullBisHundert'First, 14),
                                                                     Tundra_Enum   => (15, 30),
                                                                     Grasland_Enum => (31, 45),
                                                                     Steppe_Enum   => (46, 65),
                                                                     Savanne_Enum  => (66, 75),
                                                                     Wüste_Enum    => (76, 80),
                                                                     
                                                                     Hügel_Enum    => (81, 90),
                                                                     Gebirge_Enum  => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Gemäßigt_Enum => 
                                                                    (
                                                                     Arktisch_Enum => (SystemDatentypenHTSEB.NullBisHundert'First, 10),
                                                                     Tundra_Enum   => (11, 20),
                                                                     Grasland_Enum => (21, 50),
                                                                     Steppe_Enum   => (51, 60),
                                                                     Savanne_Enum  => (61, 70),
                                                                     Wüste_Enum    => (71, 80),
                                                                     
                                                                     Hügel_Enum    => (81, 90),
                                                                     Gebirge_Enum  => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Heiß_Enum =>
                                                                    (
                                                                     Arktisch_Enum => (SystemDatentypenHTSEB.NullBisHundert'First, 4),
                                                                     Tundra_Enum   => (5, 14),
                                                                     Grasland_Enum => (15, 30),
                                                                     Steppe_Enum   => (31, 50),
                                                                     Savanne_Enum  => (51, 65),
                                                                     Wüste_Enum    => (66, 80),
                                                                     
                                                                     Hügel_Enum    => (81, 90),
                                                                     Gebirge_Enum  => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    ),
                                                                  
                                                                  KartenartDatentypen.Warmzeit_Enum =>
                                                                    (
                                                                     Arktisch_Enum => (SystemDatentypenHTSEB.NullBisHundert'First, 0),
                                                                     Tundra_Enum   => (1, 3),
                                                                     Grasland_Enum => (4, 10),
                                                                     Steppe_Enum   => (11, 30),
                                                                     Savanne_Enum  => (31, 55),
                                                                     Wüste_Enum    => (56, 80),
                                                                     
                                                                     Hügel_Enum    => (81, 90),
                                                                     Gebirge_Enum  => (91, SystemDatentypenHTSEB.NullBisHundert'Last)
                                                                    )
                                                                 );
   
   type ZahlenNachBasisgrundArray is array (GrundwahrscheinlichkeitenArray'Range (2)) of KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   ZahlenNachBasisgrund : constant ZahlenNachBasisgrundArray := (
                                                                 Arktisch_Enum => KartenbasisgrundDatentypen.Arktisch_Enum,
                                                                 Tundra_Enum   => KartenbasisgrundDatentypen.Tundra_Enum,
                                                                 Grasland_Enum => KartenbasisgrundDatentypen.Grasland_Enum,
                                                                 Steppe_Enum   => KartenbasisgrundDatentypen.Steppe_Enum,
                                                                 Savanne_Enum  => KartenbasisgrundDatentypen.Savanne_Enum,
                                                                 Wüste_Enum    => KartenbasisgrundDatentypen.Wüste_Enum,
                                                                 Hügel_Enum    => KartenbasisgrundDatentypen.Hügel_Enum,
                                                                 Gebirge_Enum  => KartenbasisgrundDatentypen.Gebirge_Enum
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
