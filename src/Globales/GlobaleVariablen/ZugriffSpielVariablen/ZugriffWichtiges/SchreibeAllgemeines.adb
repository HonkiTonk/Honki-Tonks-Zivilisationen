with SpielVariablen;
with WichtigesRecordKonstanten;

package body SchreibeAllgemeines is
   
   -- Später erweitern damit man weiß wer gewonnen hat. äöü
   -- Vielleicht mit dem ganzen Spezies_Enum und Leer dann verwenden für keiner hat gewonnen? äöü
   procedure Gewonnen
   is begin
      
      SpielVariablen.Allgemeines.Gewonnen := True;
      
   end Gewonnen;
   
   
   
   procedure Weiterspielen
     (WeiterspielenExtern : in Boolean)
   is begin
      
      SpielVariablen.Allgemeines.Weiterspielen := WeiterspielenExtern;
      
   end Weiterspielen;
   
   
   
   procedure SpezieszugNachLaden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      SpielVariablen.Allgemeines.SpezieszugNachLaden := SpeziesExtern;
      
   end SpezieszugNachLaden;
   
      
   
   procedure Schwierigkeitsgrad
     (SchwierigkeitsgradExtern : in SpielDatentypen.Schwierigkeitsgrad_Enum)
   is begin
      
      SpielVariablen.Allgemeines.Schwierigkeitsgrad := SchwierigkeitsgradExtern;
      
   end Schwierigkeitsgrad;
   
      
   
   procedure Rundenanzahl
   is begin
      
      SpielVariablen.Allgemeines.Rundenanzahl := EigeneZahlPrüfen (GrundwertExtern  => SpielVariablen.Allgemeines.Rundenanzahl,
                                                                   ZusatzwertExtern => 1);
      
   end Rundenanzahl;
   
   
      
   procedure Rundengrenze
     (RundengrenzeExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Allgemeines.Rundengrenze := RundengrenzeExtern;
      
   end Rundengrenze;
   
   
      
   procedure Ironman
     (NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      SpielVariablen.Allgemeines.IronmanName := NameExtern;
      
   end Ironman;
   
   
   
   procedure PlanetVernichtet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      SpielVariablen.Allgemeines.PlanetVernichtet := SpeziesExtern;
      
   end PlanetVernichtet;
   
      
   
   procedure Zusammenbruchszeit
     (ZeitExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            SpielVariablen.Allgemeines.Zusammenbruchszeit := EigeneZahlPrüfen (GrundwertExtern  => SpielVariablen.Allgemeines.Zusammenbruchszeit,
                                                                               ZusatzwertExtern => ZeitExtern);
            
         when False =>
            SpielVariablen.Allgemeines.Zusammenbruchszeit := ZeitExtern;
      end case;
      
   end Zusammenbruchszeit;
   
   
   
   procedure EingesetztePZB
   is begin
      
      SpielVariablen.Allgemeines.EingesetztePZB := EigeneZahlPrüfen (GrundwertExtern  => SpielVariablen.Allgemeines.EingesetztePZB,
                                                                            ZusatzwertExtern => 1);
      
   end EingesetztePZB;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Allgemeines := WichtigesRecordKonstanten.LeerAllgemeines;
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (EintragExtern : in SpielRecords.AllgemeinesRecord)
   is begin
      
      SpielVariablen.Allgemeines := EintragExtern;
      
   end GanzerEintrag;

end SchreibeAllgemeines;
