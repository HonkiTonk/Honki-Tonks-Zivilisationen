with Sf.System.Vector2;
with Sf;

with KartenRecords;
with KartenDatentypen;

private with KartenextraDatentypen;

with LeseWeltkarteneinstellungen;

package WeltkarteFeldZeichnenGrafik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure KartenfeldZeichnen
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
   
   procedure RessourceZeichnen
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
      
   KartenfeldFluss : KartenextraDatentypen.Fluss_Enum;
   
   KartenfeldRessource : KartenextraDatentypen.Ressourcen_Enum;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;

end WeltkarteFeldZeichnenGrafik;
