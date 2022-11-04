pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

private with KartenRecords;
private with Weltkarte;
private with SystemDatentypen;

package KartengeneratorStandardLogik is
   pragma Elaborate_Body;

   procedure OberflächeGenerieren;

private
   
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
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure LandmasseAbstandGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   procedure GrundSchreiben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      MasseAbstandExtern : in Boolean)
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   
   
   function StartYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              );
     
   function StartXAchse
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      AnfangExtern : in KartenDatentypen.KartenfeldPositiv;
      EndeExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end KartengeneratorStandardLogik;
