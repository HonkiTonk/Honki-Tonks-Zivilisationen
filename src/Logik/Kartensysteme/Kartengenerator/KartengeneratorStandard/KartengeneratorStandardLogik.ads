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
   WahrscheinlichkeitLandmasse : constant WahrscheinlichkeitenRecord := (20, 80);
   
   WahrscheinlichkeitLand : constant WahrscheinlichkeitenRecord := (0, 95);
   WahrscheinlichkeitWasser : constant WahrscheinlichkeitenRecord := (0, 95);
   
   type QuadrantenArray is array (1 .. 25) of SystemDatentypen.NullBisHundert;
   Quadranten : constant QuadrantenArray := (13 => 100,
                                             7  => 50,
                                             8  => 50,
                                             9  => 50,
                                             12 => 50,
                                             14 => 50,
                                             17 => 50,
                                             18 => 50,
                                             19 => 50,
                                             others => 25);

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
