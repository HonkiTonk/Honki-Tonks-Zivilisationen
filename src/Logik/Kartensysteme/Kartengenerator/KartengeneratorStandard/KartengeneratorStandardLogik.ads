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
   
   ÜbergangNorden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   ÜbergangSüden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   
   ÜbergangWesten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   ÜbergangOsten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   
   YAchseZwischenwert : KartenDatentypen.SenkrechtePositiv;
   XAchseZwischenwert : KartenDatentypen.SenkrechtePositiv;
   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;
   
   YAchseAnfang : KartenDatentypen.Senkrechte;
   YAchseEnde : KartenDatentypen.Senkrechte;
   XAchseAnfang : KartenDatentypen.Waagerechte;
   XAchseEnde : KartenDatentypen.Waagerechte;
      
   type LandmassenArray is array (1 .. 4) of KartenDatentypen.SenkrechtePositiv;
   Landmassen : LandmassenArray;
   Landabstand : LandmassenArray;
   
   BeliebigerLandwert : SystemDatentypen.NullBisHundert;
   Quadrantenwert : SystemDatentypen.NullBisHundert;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
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
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      XAchseExtern : in KartenDatentypen.WaagerechtePositiv)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure LandmasseAbstandGenerieren
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      XAchseExtern : in KartenDatentypen.WaagerechtePositiv)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Wassergrund
     (YAchseExtern : in KartenDatentypen.SenkrechteNatural;
      XAchseExtern : in KartenDatentypen.WaagerechteNatural)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure Landgrund
     (YAchseExtern : in KartenDatentypen.SenkrechteNatural;
      XAchseExtern : in KartenDatentypen.WaagerechteNatural)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );
   
   
   
   function StartYAchse
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      AnfangExtern : in KartenDatentypen.SenkrechtePositiv;
      EndeExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              );
     
   function StartXAchse
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      AnfangExtern : in KartenDatentypen.WaagerechtePositiv;
      EndeExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorStandardLogik;
