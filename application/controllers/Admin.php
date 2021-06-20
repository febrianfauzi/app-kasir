<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Admin extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('form_validation');
    }


    public function index()
    {
        $this->form_validation->set_rules('username', 'Username', 'trim|required');
        $this->form_validation->set_rules('password', 'Password', 'trim|required');

        if ($this->form_validation->run() === false) {
            $this->load->view('admin/login');
        } else {
            $this->_login();
        }
    }

    private function _login()
    {
        $username = $this->input->post('username');
        $password = $this->input->post('password');

        $user = $this->db->get_where('user', ['username' => $username])->row_array();
        // jika user ditemukan
        if ($user) {
            //cek password
            if (password_verify($password, $user['password']) && $user['role'] === '1') {

                $data = [
                    'id_user' => $user['id_user'],
                    'username' => $user['username'],
                    'role' => $user['role']
                ];
                $this->session->set_userdata($data);

                $dataLogin = array(
                    'tgl_login' => time(),
                    'id_user' => $user['id_user'],
                    'jenis' => 'login'
                );
                $this->db->insert('t_hist_login', $dataLogin);
                redirect('admin/dashboard');

            } else {
                $this->session->set_flashdata('pesan', '<div class="alert alert-danger" role="alert">Password salah</div>');
                redirect('admin');
            }
        } else {
            $this->session->set_flashdata('pesan', '<div class="alert alert-danger" role="alert">User tidak ditemukan</div>');
            redirect('admin');
        }
    }

    public function logout()
    {
        $user_id = $this->session->userdata('id_user');
        $dataLogout = array(
            'tgl_login' => time(),
            'id_user' => $user_id,
            'jenis' => 'logout'
        );
        $this->db->insert('t_hist_login', $dataLogout);

        $this->session->unset_userdata('username');
        $this->session->unset_userdata('role');
        $this->session->unset_userdata('id_user');
        $this->session->set_flashdata('pesan', '<div class="alert alert-success" role="alert">Anda telah logout !</div>');
        redirect('admin');
    }

    public function dashboard()
    {
        if (!$this->session->userdata('role')) {
            $this->session->set_flashdata('pesan', '<div class="alert alert-danger" role="alert">Login dahulu !</div>');
            redirect('admin');
        } else {
            $data = ['title' => 'Dashboard Admin'];
            $this->load->view('template/header', $data);
            $this->load->view('admin/dashboard', $data);
            $this->load->view('template/footer');
        }
    }
}
?>

