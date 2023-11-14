with Spieltexte;
with StadtKonstanten;
with TextnummernKonstanten;
with TextKonstanten;
with Projekteinstellungen;
with SystemDatentypen;
with SpeziesKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with EinheitenbeschreibungenGrafik;
with KampfwerteEinheitErmittelnLogik;
with TextaccessverwaltungssystemErweitertGrafik;
with DebuginformationenGrafik;
with TextberechnungenHoeheGrafik;

package body EinheitenseitenleisteGrafik is

   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        SpeziesExtern = SpeziesKonstanten.LeerSpezies
        or
          EinheitSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
      then
         EinheitSpeziesNummer.Nummer := EinheitenKonstanten.LeerWirdTransportiert;
         
      else
         EinheitSpeziesNummer.Nummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
      case
        EinheitSpeziesNummer.Nummer
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitSpeziesNummer := EinheitSpeziesNummerExtern;
                        
         when others =>
            EinheitSpeziesNummer.Spezies := EinheitSpeziesNummerExtern.Spezies;
      end case;
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
      case
        IDEinheit
      is
         when EinheitenKonstanten.LeerID =>
            -- Das +2 kommt vom Zeilenumbruch für Arbeit und Herkunft.
            YTextposition := TextberechnungenHoeheGrafik.Leerzeilen (LeerzeilenExtern => AnzuzeigenderText'Last + 2,
                                                                     PositionExtern   => TextpositionExtern.y);
            
         when others =>
            YTextposition := Einheitenanzeige (SpeziesExtern              => SpeziesExtern,
                                               IDExtern                   => IDEinheit,
                                               EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                               TextpositionExtern         => TextpositionExtern,
                                               MaximaleTextbreiteExtern   => MaximaleTextbreiteExtern);
      end case;
      
      case
        Projekteinstellungen.Debug.VolleInformation
      is
         when True =>
            YTextposition := DebuginformationenGrafik.EInheiteninformationenKI (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                TextpositionExtern         => (TextpositionExtern.x, YTextposition),
                                                                                MaximaleTextbreiteExtern   => MaximaleTextbreiteExtern);
            
         when False =>
            null;
      end case;
      
      return YTextposition;
      
   end Einheiten;
   
   
   
   function Einheitenanzeige
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Leerzeilen := 0;
      YTextpositionZwei := TextpositionExtern.y;
            
      AnzuzeigenderText (1) := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => IDExtern,
                                                                                                                        SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
      AnzuzeigenderText (2) := Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                             IDExtern                   => IDExtern);
            
      if
        SpeziesExtern = EinheitSpeziesNummerExtern.Spezies
        or
          Projekteinstellungen.Debug.VolleInformation
      then
         AnzuzeigenderText (3) := Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   IDExtern                   => IDExtern);
         AnzuzeigenderText (4) := Erfahrungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    IDExtern                   => IDExtern);
         AnzuzeigenderText (5) := Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                        IDExtern                   => IDExtern);
         AnzuzeigenderText (Arbeit) := Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         AnzuzeigenderText (7) := Kampfwerte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         AnzuzeigenderText (Herkunft) := Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         AnzuzeigenderText (9) := Ladung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                          IDExtern                   => IDExtern);
         
      else
         AnzuzeigenderText (3 .. 9) := (others => TextKonstanten.LeerUnboundedString);
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
         
         if
           AnzuzeigenderText (TextSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Leerzeilen := Leerzeilen + 1;
            
         else
            YTextpositionZwei := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => AnzuzeigenderText (TextSchleifenwert)),
                                                                                                   TextpositionExtern       => (TextpositionExtern.x, YTextpositionZwei),
                                                                                                   MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                   TextAccessExtern         => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert));
         end if;
            
         case
           TextSchleifenwert
         is
            when Arbeit | Herkunft =>
               -- Kann nicht wie bei der Stadt durch Leerzeilen + 1 ersetzt werden, da im Gegensatz zum Bauprojekt diese beiden Informationen nicht am Ende stehen.
               YTextpositionZwei := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => YTextpositionZwei,
                                                                                  ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
               
            when others =>
               null;
         end case;
         
      end loop TextSchleife;
      
      return TextberechnungenHoeheGrafik.Leerzeilen (LeerzeilenExtern => Leerzeilen,
                                                     PositionExtern   => YTextpositionZwei);
      
   end Einheitenanzeige;
   
   
   
   function Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & " " & LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image
        & TextKonstanten.Trennzeichen & ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                              IDExtern      => IDExtern));
        
   end Lebenspunkte;
   
   
   
   function Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image
        & TextKonstanten.Trennzeichen & ZahlAlsStringBewegungspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                    IDExtern      => IDExtern));
      
   end Bewegungspunkte;
   
   
   
   function Erfahrungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugErfahrungspunkte) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image
        & TextKonstanten.Trennzeichen & ZahlAlsStringErfahrungspunkte (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                 IDExtern      => IDExtern));
      
   end Erfahrungspunkte;
   
   
   
   function Rang
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugRang) & LeseEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image & TextKonstanten.Trennzeichen
        & ZahlAlsStringRang (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                 IDExtern      => IDExtern));
      
   end Rang;
   
   
   
   function Aufgabe
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Beschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Beschäftigung
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugBeschäftigung) & TextKonstanten.UmbruchAbstand & Spieltexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugBeschäftigung) & TextKonstanten.UmbruchAbstand & EinheitenbeschreibungenGrafik.KurzbeschreibungBeschäftigung (Beschäftigung) & " (" &
              ZahlAlsStringArbeitszeit (ZahlExtern => LeseEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) & ")";
      end case;
      
   end Aufgabe;
   
   
   
   function Kampfwerte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & " "
        & ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                                TaskExtern                 => SystemDatentypen.Grafik_Task_Enum))
        & " " & TextKonstanten.TrennzeichenUnterschiedlich & " "
        & ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                                     TaskExtern                 => SystemDatentypen.Grafik_Task_Enum));
      
   end Kampfwerte;
   
   
   
   -- Kann man das hier auch so anpassen wie bei der Stadt/Einheitenauswahl?
   function Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin

      Stadtnummer := LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
      case
        Stadtnummer
      is
         when StadtKonstanten.LeerNummer =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugHeimatstadt) & TextKonstanten.UmbruchAbstand & Spieltexte.Zeug (TextnummernKonstanten.ZeugKeines);
               
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugHeimatstadt) & TextKonstanten.UmbruchAbstand & LeseStadtGebaut.Name (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Stadtnummer));
      end case;
      
   end Heimatstadt;
   
   
   
   function Ladung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is
      use type EinheitenDatentypen.Einheitenbereich;
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      case
        LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                   IDExtern      => IDExtern)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            MaximaleLadung := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                          IDExtern      => IDExtern);
            VorhandeneLadung := 0;
      end case;
                        
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. MaximaleLadung loop
         
         if
           EinheitenKonstanten.LeerTransportiert /= LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                       PlatzExtern                => LadungSchleifenwert)
         then
            VorhandeneLadung := VorhandeneLadung + 1;
            
         else
            null;
         end if;
            
      end loop LadungSchleife;
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung) & VorhandeneLadung'Wide_Wide_Image & "/" & ZahlAlsStringTransportplätze (ZahlExtern => MaximaleLadung);
      
   end Ladung;
   
end EinheitenseitenleisteGrafik;
