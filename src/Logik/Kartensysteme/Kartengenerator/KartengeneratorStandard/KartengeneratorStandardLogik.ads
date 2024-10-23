private with KartenDatentypen;
private with KartenRecords;
private with SystemDatentypen;
private with KartenartDatentypen;

private with LeseWeltkarteneinstellungen;

private with AllgemeineBerechnungen;

package KartengeneratorStandardLogik is
   pragma Elaborate_Body;

   procedure OberflächeGenerieren;

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   LandHöheBreite : Boolean;
   
   ÜbergangNorden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   ÜbergangSüden : KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   
   ÜbergangWesten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   ÜbergangOsten : KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   
   SenkrechteZwischenwert : KartenDatentypen.SenkrechtePositiv;
   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;
   
   WaagerechteZwischenwert : KartenDatentypen.WaagerechtePositiv;
   
   SenkrechteAnfang : KartenDatentypen.Senkrechte;
   SenkrechteEnde : KartenDatentypen.Senkrechte;
   
   WaagerechteAnfang : KartenDatentypen.Waagerechte;
   WaagerechteEnde : KartenDatentypen.Waagerechte;
      
   type LandmassenArray is array (1 .. 2) of KartenRecords.KartenfeldumgebungPositivRecord;
   Landmassen : LandmassenArray;
   Landabstand : LandmassenArray;
   
   BeliebigerLandwert : SystemDatentypen.NullBisHundert;
   Quadrantenwert : SystemDatentypen.NullBisHundert;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   type WahrscheinlichkeitenRecord is record
      
      Anfangswert : SystemDatentypen.NullBisHundert;
      Endwert : SystemDatentypen.NullBisHundert;
      
   end record;
   
   -- Später Nutzereinstellbar machen. äöü
   WahrscheinlichkeitLandmasse : constant WahrscheinlichkeitenRecord := (20, 80);
   
   WahrscheinlichkeitLand : constant WahrscheinlichkeitenRecord := (0, 95);
   WahrscheinlichkeitWasser : constant WahrscheinlichkeitenRecord := (0, 95);
   
   ZentrumWahrscheinlichkeit : constant SystemDatentypen.NullBisHundert := 100;
   MitteWahrscheinlichkeit : constant SystemDatentypen.NullBisHundert := 55;
   RandWahrscheinlichkeit : constant SystemDatentypen.NullBisHundert := 25;
   
   type QuadrantenArray is array (KartenDatentypen.KartengeneratorQuadranten'Range) of SystemDatentypen.NullBisHundert;
   Quadranten : constant QuadrantenArray := (13     => ZentrumWahrscheinlichkeit,
                                             7      => MitteWahrscheinlichkeit,
                                             8      => MitteWahrscheinlichkeit,
                                             9      => MitteWahrscheinlichkeit,
                                             12     => MitteWahrscheinlichkeit,
                                             14     => MitteWahrscheinlichkeit,
                                             17     => MitteWahrscheinlichkeit,
                                             18     => MitteWahrscheinlichkeit,
                                             19     => MitteWahrscheinlichkeit,
                                             others => RandWahrscheinlichkeit);

   procedure LandVorhanden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure LandmasseAbstandGenerieren
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Wassergrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure Landgrund
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural;
      WaagerechteExtern : in KartenDatentypen.WaagerechteNatural)
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   function StartSenkrechte
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      AnfangExtern : in KartenDatentypen.SenkrechtePositiv;
      EndeExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              );
     
   function StartWaagerechte
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      AnfangExtern : in KartenDatentypen.WaagerechtePositiv;
      EndeExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorStandardLogik;
