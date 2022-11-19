private with KartenDatentypen;
private with KartenRecords;
private with SystemDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorStandardLogik is
   pragma Elaborate_Body;

   procedure OberflächeGenerieren;

private
   use type KartenDatentypen.Kartenfeld;
   
   LandHöheBreite : Boolean;
   
   YAchseZwischenwert : KartenDatentypen.KartenfeldPositiv;
   XAchseZwischenwert : KartenDatentypen.KartenfeldPositiv;
   
   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;
      
   type LandmassenArray is array (1 .. 4) of KartenDatentypen.KartenfeldPositiv;
   Landmassen : LandmassenArray;
   Landabstand : LandmassenArray;
   
   BeliebigerLandwert : SystemDatentypen.NullBisHundert;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type WahrscheinlichkeitenRecord is record
      
      Anfangswert : SystemDatentypen.NullBisHundert;
      Endwert : SystemDatentypen.NullBisHundert;
      
   end record;
   
   -- Später Nutzereinstellbar machen. äöü
   WahrscheinlichkeitLandmasse : constant WahrscheinlichkeitenRecord := (20, 80);
   WahrscheinlichkeitLandInLandmasse : constant WahrscheinlichkeitenRecord := (0, 90);
   WahrscheinlichkeitWasser : constant WahrscheinlichkeitenRecord := (0, 90);

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

   procedure GrundSchreiben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      MasseAbstandExtern : in Boolean)
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
