with Sf.System.Vector2;
with Sf;

with KartenRecords;
with KartenDatentypen;

private with KartenfluesseDatentypen;
private with KartenzusatzgrundDatentypen;
private with KartenArrays;
private with KartenwegeDatentypen;

with LeseWeltkarteneinstellungen;

package WeltkartenfeldZeichnenGrafik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure BasisgrundZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure ZusatzgrundZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure RohstoffeZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure VerbesserungenZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure AnzeigeFeldeffekt
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
private
   
   Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
         
   KartenfeldFluss : KartenfluesseDatentypen.Fluss_Enum;
   
   Wegfeld : KartenwegeDatentypen.Weg_Enum;
   
   Rohstoffposition : Sf.System.Vector2.sfVector2f;
   Verbesserungsposition : Sf.System.Vector2.sfVector2f;
   Kartenfeld : Sf.System.Vector2.sfVector2f;
   
   Rohstoffe : KartenArrays.RohstoffeArray;
   
   Verbesserungen : KartenArrays.VerbesserungenArray;

end WeltkartenfeldZeichnenGrafik;
