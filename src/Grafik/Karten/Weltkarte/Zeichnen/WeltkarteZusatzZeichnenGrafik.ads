with Sf;
with Sf.System.Vector2;

private with Sf.Graphics.Color;

with KartenRecords;
with SpeziesDatentypen;
with KartenDatentypen;
with KartenartDatentypen;

private with KartenverbesserungDatentypen;
private with StadtRecords;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package WeltkarteZusatzZeichnenGrafik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   procedure RahmenZeichnen
     (WelcheRichtungExtern : in KartenartDatentypen.Himmelsrichtungen_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure AnzeigeFeldeffekt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      ObenUntenExtern : in Boolean)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
private
   
   AktuelleSpezies : SpeziesDatentypen.Spezies_Enum;
   
   Stadtart : KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
   Wegfeld : KartenverbesserungDatentypen.Weg_Enum;
   Verbesserungsfeld : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   DickeRahmen : constant Float := 5.00;
         
   StadtSpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;
   
   Rahmenposition : Sf.System.Vector2.sfVector2f;
   Rahmengröße : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   Textgröße : Sf.System.Vector2.sfVector2f;
   
   KartenWertRahmen : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Farbe : Sf.Graphics.Color.sfColor;
      
   type UmgebungArray is array (KartenartDatentypen.Himmelsrichtungen_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Umgebung : constant UmgebungArray := (
                                         KartenartDatentypen.Norden_Enum => (0, -1, 0),
                                         KartenartDatentypen.Westen_Enum => (0, 0, -1),
                                         KartenartDatentypen.Osten_Enum  => (0, 0, 1),
                                         KartenartDatentypen.Süden_Enum  => (0, 1, 0)
                                        );

end WeltkarteZusatzZeichnenGrafik;
