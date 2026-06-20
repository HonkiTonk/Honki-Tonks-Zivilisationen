with Ada.Exceptions; use Ada.Exceptions;
  
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;

with LeseWeltkarte;

package body SpeichernBasisgrundLogik is
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
        use type KartengrundDatentypen.Basisgrund_Kernfläche_Enum;
   begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.WeltraumKonstante | KartenKonstanten.HimmelKonstante =>
            null;
            
         when KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
            
         when KartenKonstanten.UnterflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
            
         when KartenKonstanten.PlaneteninneresKonstante =>
            Kerngrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
            -- Der Kern basiert doch auf der Kartengröße, kann ich den dann nicht einfach überspringen und beim Laden mit Kern auffüllen? äöü
            -- Das hier lieber direkt in die Koordinatenschleife packen? äöü
            
            if
              Kerngrund = KartengrundDatentypen.Planetenkern_Enum
            then
               null;
               
            else
               KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                      Kerngrund);
            end if;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKartenbelegungLogik.Basisgrund: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Basisgrund;

end SpeichernBasisgrundLogik;
