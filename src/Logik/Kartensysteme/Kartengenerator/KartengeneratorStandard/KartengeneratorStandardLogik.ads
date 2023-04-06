private with KartenDatentypen;
private with KartenRecords;
private with SystemDatentypen;
private with KartenartDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorStandardLogik is
   pragma Elaborate_Body;

   procedure OberflächeGenerieren;

private
   use type KartenDatentypen.Kartenfeld;
   
   LandHöheBreite : Boolean;
   
   ÜbergangNorden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   ÜbergangSüden : KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   
   ÜbergangWesten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   ÜbergangOsten : KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   
   YAchseZwischenwert : KartenDatentypen.KartenfeldPositiv;
   XAchseZwischenwert : KartenDatentypen.KartenfeldPositiv;
   
   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;
   
   YAchseAnfang : KartenDatentypen.Kartenfeld;
   YAchseEnde : KartenDatentypen.Kartenfeld;
   XAchseAnfang : KartenDatentypen.Kartenfeld;
   XAchseEnde : KartenDatentypen.Kartenfeld;
      
   type LandmassenArray is array (1 .. 4) of KartenDatentypen.KartenfeldPositiv;
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
   -- Alles oder nur Teile davon? äöü
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
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure LandmasseAbstandGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Wassergrund
     (YAchseExtern : in KartenDatentypen.KartenfeldNatural;
      XAchseExtern : in KartenDatentypen.KartenfeldNatural)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure Landgrund
     (YAchseExtern : in KartenDatentypen.KartenfeldNatural;
      XAchseExtern : in KartenDatentypen.KartenfeldNatural)
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
               and
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );
   
   
   
   function StartYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              );
     
   function StartXAchse
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              );

end KartengeneratorStandardLogik;
